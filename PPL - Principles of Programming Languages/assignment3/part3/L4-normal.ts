// ========================================================
// L4 normal eval
import { Sexp } from "s-expression";
import { CExp, Exp, IfExp, Program, parseL4Exp, isLetExp, LetExp, Binding, VarDecl} from "./L4-ast";
import { isAppExp, isBoolExp, isCExp, isDefineExp, isIfExp, isLitExp, isNumExp,
         isPrimOp, isProcExp, isStrExp, isVarRef } from "./L4-ast";
import { applyEnv, makeEmptyEnv, Env, makeExtEnv, Pair, makePair, makeRecEnv } from './L4-env-normal';
import { applyPrimitive } from "./evalPrimitive";
import { isClosure, makeClosure, Value } from "./L4-value";
import { first, rest, isEmpty } from '../shared/list';
import { Result, makeOk, makeFailure, bind, mapResult } from "../shared/result";
import { parse as p } from "../shared/parser";
import { map } from "ramda";

/*
Purpose: Evaluate an L4 expression with normal-eval algorithm
Signature: L4-normal-eval(exp,env)
Type: CExp * Env => Value
*/
export const L4normalEval = (exp: CExp, env: Env): Result<Value> =>
    isBoolExp(exp) ? makeOk(exp.val) :
    isNumExp(exp) ? makeOk(exp.val) :
    isStrExp(exp) ? makeOk(exp.val) :
    isPrimOp(exp) ? makeOk(exp) :
    isLitExp(exp) ? makeOk(exp.val) :
    isVarRef(exp) ? bind(applyEnv(env, exp.var), (pair:Pair) => L4normalEval(pair.cexp, pair.env)) :
    isIfExp(exp) ? evalIf(exp, env) :
    isProcExp(exp) ? makeOk(makeClosure(exp.args, exp.body, env)) :
    // This is the difference between applicative-eval and normal-eval
    // Substitute the arguments into the body without evaluating them first.
    isAppExp(exp) ? bind(L4normalEval(exp.rator, env), proc => L4normalApplyProc(proc, exp.rands, env)) :
    isLetExp(exp) ? evalLet(exp, env) :
    makeFailure(`Bad ast: ${exp}`);

export const evalIf = (exp: IfExp, env: Env): Result<Value> =>
    bind(L4normalEval(exp.test, env),
         test => isTrueValue(test) ? L4normalEval(exp.then, env) : L4normalEval(exp.alt, env));

export const evalLet = (exp: LetExp, env: Env): Result<Value> => {
    const vals = map((b: Binding) => makePair(b.val, env), exp.bindings);
    const vars = map((b: Binding) => b.var.var, exp.bindings);
    return evalExps(exp.body, makeExtEnv(vars, vals, env));
}

export const isTrueValue = (x: Value): boolean =>
    ! (x === false);
             
/*
===========================================================
Normal Order Application handling
Purpose: Apply a procedure to NON evaluated arguments.
Signature: L4-normalApplyProcedure(proc, args)
Pre-conditions: proc must be a prim-op or a closure value
*/
export const L4normalApplyProc = (proc: Value, args: CExp[], env: Env): Result<Value> => {
    if (isPrimOp(proc)) {
        const argVals: Result<Value[]> = mapResult((arg) => L4normalEval(arg, env), args);
        return bind(argVals, (args: Value[]) => applyPrimitive(proc, args));
    } else if (isClosure(proc)) {
        const vars = map((v: VarDecl) => v.var, proc.params);
        const args_map = map((v:CExp)=> makePair(v, env), args);
        return evalExps(proc.body, makeExtEnv(vars, args_map, proc.env));
    } else {
        return makeFailure(`Bad proc applied ${proc}`);
    }
};
    
export const evalCExps = (exp1: Exp, exps: Exp[], env: Env): Result<Value> =>
    isCExp(exp1) && isEmpty(exps) ? L4normalEval(exp1, env) :
    isCExp(exp1) ? bind(L4normalEval(exp1, env), _ => evalExps(exps, env)) :
    makeFailure("Never");
    
// Eval a sequence of expressions when the first exp is a Define.
// Compute the rhs of the define, extend the env with the new binding
// then compute the rest of the exps in the new env.
export const evalDefineExps = (def: Exp, exps: Exp[], env: Env): Result<Value> =>
    // extend env for next exps with no computing value of define
    isDefineExp(def) ? 
    isProcExp(def.val) ? evalExps(exps, makeRecEnv([def.var.var],[[def.var]], [[def.val]], env)):
    evalExps(exps, makeExtEnv([def.var.var], [makePair(def.val, env)], env)):
    makeFailure("Unexpected " + def);


// Evaluate a sequence of expressions (in a program)
export const evalExps = (exps: Exp[], env: Env): Result<Value> =>
    isEmpty(exps) ? makeFailure("Empty program") :
    isDefineExp(first(exps)) ? evalDefineExps(first(exps), rest(exps), env) :
    evalCExps(first(exps), rest(exps), env);

/*
Purpose: evaluate a program made up of a sequence of expressions. (Same as in L1)
When def-exp expressions are executed, thread an updated env to the continuation.
For other expressions (that have no side-effect), execute the expressions sequentially.
Signature: L4normalEvalProgram(program)
Type: [Program -> Value]
*/
export const evalNormalProgram = (program: Program): Result<Value> =>
    evalExps(program.exps, makeEmptyEnv());

export const evalNormalParse = (s: string): Result<Value> =>
    bind(p(s),
         (parsed: Sexp) => bind(parseL4Exp(parsed),
                                (exp: Exp) => evalExps([exp], makeEmptyEnv())));