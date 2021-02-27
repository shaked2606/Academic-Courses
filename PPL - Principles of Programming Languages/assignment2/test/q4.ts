import { Exp, Program, isProgram, isIfExp, isBoolExp, isNumExp, isVarRef, isPrimOp, isDefineExp, isProcExp, isAppExp} from '../imp/L2-ast';
import { Result, makeFailure, makeOk, mapResult, bind, safe3, safe2 } from '../imp/result';
import { map } from 'ramda';

/*
Purpose: transforms a given LS program to a JS program
Signature: l2ToJS(exp)
Type: [ (exp | Program) => Result<string> ]
*/
export const l2ToJS = (exp: Exp | Program): Result<string> => 
isProgram(exp) ? bind(mapResult(l2ToJS, exp.exps), (exps: string[]) => 
exps.length > 1 ? makeOk(`${exps.slice(0, exps.length-1).join(";\n")};\nconsole.log(${exps.slice(exps.length-1,exps.length)});`) :
exps.length === 1 ? makeOk(`${exps}`) :
makeFailure(`Unknown expression: ${exp}`)) :

isBoolExp(exp) ? makeOk(exp.val ? "true" : "false") :
isNumExp(exp) ? makeOk(exp.val.toString()) : 
isVarRef(exp) ? makeOk(exp.var) : 
isPrimOp(exp) ? makeOk(exp.op === "not" ? "!":
                       exp.op === "and" ? "&&":
                       exp.op === "or" ? "||":
                       exp.op === "eq?" || exp.op === "=" ? "===":
                       exp.op === "number?" || exp.op === "boolean?" ? "":
                       exp.op) :
isDefineExp(exp) ? bind(l2ToJS(exp.val), (val: string) => makeOk(`const ${exp.var.var} = ${val}`)) :

isProcExp(exp) ? bind(mapResult(l2ToJS, exp.body), (body: string[]) => 
body.length > 1 ? makeOk(`((${map(v => v.var, exp.args).join(",")}) => {${body.slice(0, body.length-1).join("; ")}; return ${body.slice(body.length-1,body.length)};})`) :
body.length === 1 ? makeOk(`((${map(v => v.var, exp.args).join(",")}) => ${body.join(" ")})`) :
makeFailure(`Unknown expression: ${exp}`)) :

isIfExp(exp) ? safe3((test: string, then: string, alt: string) => makeOk(`(${test} ? ${then} : ${alt})`))
(l2ToJS(exp.test), l2ToJS(exp.then), l2ToJS(exp.alt)) : 

isAppExp(exp) ? 
    isPrimOp(exp.rator) ? 
    exp.rator.op === "not" ? safe2((rator: string, rands: string[]) => makeOk(`(${rator}${rands[0]})`)) (l2ToJS(exp.rator), mapResult(l2ToJS, exp.rands)):
    exp.rator.op === "number?" ? safe2((rator: string, rands: string[]) => makeOk(`(typeof ${rands[0]} === 'number')`)) (l2ToJS(exp.rator), mapResult(l2ToJS, exp.rands)):
    exp.rator.op === "boolean?" ? safe2((rator: string, rands: string[]) => makeOk(`(typeof ${rands[0]} === 'boolean')`)) (l2ToJS(exp.rator), mapResult(l2ToJS, exp.rands)):
    safe2((rator: string, rands: string[]) => makeOk(`(${rands.join(` ${rator} `)})`)) (l2ToJS(exp.rator), mapResult(l2ToJS, exp.rands)) :
    isVarRef(exp.rator) ? safe2((rator: string, rands: string[]) => makeOk(`${rator}(${rands.join(`,`)})`)) (l2ToJS(exp.rator), mapResult(l2ToJS, exp.rands)):
    isProcExp(exp.rator) ? safe2((rator: string, rands: string[]) => makeOk(`${rator}(${rands.join(`,`)})`)) (l2ToJS(exp.rator), mapResult(l2ToJS, exp.rands)) :
    makeFailure(`Unknown expression: ${exp}`):
makeFailure(`Unknown expression: ${exp}`);