import { ForExp, AppExp, Exp, isExp, Program, makeAppExp, makeProcExp,makeNumExp, isProgram, makeProgram, isDefineExp, isCExp, makeDefineExp, isAtomicExp, isIfExp, makeIfExp, isAppExp, CExp, isProcExp, isForExp, makeForExp} from "./L21-ast";
import { Result, makeOk, makeFailure, safe2, safe3, mapResult, bind } from "../imp/result";
import { map, range } from "ramda";

/*
Purpose: Applies a syntactic transformation from a ForExp to an equivalent AppExp
Signature: for2app(exp)
Type: [ ForExp -> AppExp ]
*/
export const for2app = (exp: ForExp): AppExp =>
{
    const start = exp.start.val;
    const end = exp.end.val;

    const range_array = map((i) => makeNumExp(i), range(start, end + 1));
    
    const cexps = map((i) => makeAppExp(makeProcExp([exp.var], [exp.body]), [i]), range_array);

    return makeAppExp(makeProcExp([],cexps),[]);
};

/*
Purpose: Turn L21 AST to an equivalent L2 AST
Signature: L21ToL2(exp)
Type: [ Exp | Program -> Result<Exp | Program> ]
*/
export const L21ToL2 = (exp: Exp | Program): Result<Exp | Program> => 
    isExp(exp) ? rewriteAllL21Exp(exp) :
    isProgram(exp) ? bind(mapResult(rewriteAllL21Exp, exp.exps),
    (exps:Exp[]) => makeOk(makeProgram(exps))) :
    makeFailure("Unexpected expression " + exp);

export const rewriteAllL21Exp = (exp: Exp): Result<Exp> =>
    isCExp(exp) ? rewriteAllL21CExp(exp) :
    isDefineExp(exp) ? bind(rewriteAllL21CExp(exp.val),
    (value:CExp) => makeOk(makeDefineExp(exp.var,value))) :
    makeFailure("Unexpected expression " + exp);
        
export const rewriteAllL21CExp = (exp: CExp): Result<CExp> =>
    isAtomicExp(exp) ? makeOk(exp) :

    isIfExp(exp) ? safe3((test: CExp, then: CExp, alt: CExp) : Result<CExp> => makeOk(makeIfExp(test, then, alt)))
    (rewriteAllL21CExp(exp.test), rewriteAllL21CExp(exp.then), rewriteAllL21CExp(exp.alt)) :

    isAppExp(exp) ? safe2((rator: CExp, rands: CExp[]) : Result<CExp> => makeOk(makeAppExp(rator, rands)))
    (rewriteAllL21CExp(exp.rator), mapResult(rewriteAllL21CExp, exp.rands)) :

    isProcExp(exp) ? bind(mapResult(rewriteAllL21CExp, exp.body),
    (cexps: CExp[]) => makeOk(makeProcExp(exp.args, cexps))) :

    isForExp(exp) ? 
    ((exp.start.val > exp.end.val) ? makeFailure("start > end - No procedure without body") :
    bind(rewriteAllL21CExp(exp.body),
    (cexps: CExp) => makeOk(for2app(makeForExp(exp.var, exp.start, exp.end, cexps))))) :
    makeFailure("Unexpected expression " + exp);
