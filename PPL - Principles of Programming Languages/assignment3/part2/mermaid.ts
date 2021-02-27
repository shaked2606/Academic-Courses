// ===========================================================
import { Result, makeFailure, makeOk, mapResult, bind, safe2, safe3, isOk, isFailure } from "../shared/result";
import { Graph, makeGraph, makeNodeDecl, Node, Edge, makeEdge, isAtomicGraph, GraphContent, makeNodeRef, isCompoundGraph, isGraph, isNodeDecl, isNodeRef, isEdge } from "./mermaid-ast";
import { Parsed,isProgram, isDefineExp, isProcExp, isAppExp, isIfExp, isLetExp, isLitExp, isLetrecExp, isSetExp, isNumExp, isBoolExp, isStrExp, isPrimOp, isVarRef, DefineExp, AppExp, makeVarRef, makePrimOp, makeAppExp, makeVarDecl, makeDefineExp, IfExp, Program, ProcExp, makeNumExp, makeBoolExp, parseL4, SetExp, LetExp, LitExp, LetrecExp, parseL4Program, isCompoundExp, makeProgram, Exp, CExp, makeStrExp, makeIfExp, makeProcExp, Binding, makeBinding, makeLetExp, makeLetrecExp, makeLitExp, makeSetExp, VarDecl} from "./L4-ast";
import { cons, isEmpty, first, rest, second, allT } from "../shared/list";
import { chain, map, zipWith, flatten } from "ramda";
import { isEmptySExp, isSymbolSExp, isCompoundSExp, valueToString, SExpValue, CompoundSExp, SymbolSExp, makeCompoundSExp, makeSymbolSExp, makeEmptySExp } from "./L4-value";
import { isNumber, isBoolean, isString, isArray, isIdentifier, isNumericString } from "../shared/type-predicates";
import { parse as p, isToken, isSexpString} from "../shared/parser";
import { Sexp, Token } from "s-expression";
import { S_IFSOCK } from "constants";

// Function makes unique name for variable
const makeVarGen = (nodeName: string): () => string => {
    let count = 0;
    return () => `${nodeName}_${++count}`;
}
const numberGen = makeVarGen("number");
const booleanGen = makeVarGen("boolean");
const stringGen = makeVarGen("string");
const numExpGen = makeVarGen("NumExp");
const boolExpGen = makeVarGen("BoolExp");
const strExpGen = makeVarGen("StrExp");
const varRefGen = makeVarGen("VarRef");
const primOpGen = makeVarGen("PrimOp");
const litExpGen = makeVarGen("LitExp");
const appExpGen = makeVarGen("AppExp");
const ifExpGen = makeVarGen("IfExp");
const procExpGen = makeVarGen("ProcExp");
const paramsGen = makeVarGen("Params");
const bodyGen = makeVarGen("Body");
const letExpGen = makeVarGen("LetExp");
const letrecExpGen = makeVarGen("LetrecExp");
const setExpGen = makeVarGen("SetExp");
const defineExpGen = makeVarGen("DefineExp");
const progGen = makeVarGen("Program");
const expsGen = makeVarGen("Exps");
const varDeclGen = makeVarGen("VarDecl");
const randsGen = makeVarGen("Rands");
const bindingsGen = makeVarGen("Bindings");
const bindingGen = makeVarGen("Binding");
const compoundSexpGen = makeVarGen("CompoundSExp");
const symbolSexpGen = makeVarGen("SymbolSExp");
const emptySExpGen = makeVarGen("EmptySExp");


const parseL4toParsed = (x: string): Result<Parsed> =>
    bind(p(x), parseL4ProgramOrExp);

export const parseL4ProgramOrExp = (sexp: Sexp): Result<Parsed> =>
    sexp === "" || isEmpty(sexp) ? makeFailure("Unexpected empty program") :
    isToken(sexp) ? parseL4Atomic(sexp) :
    isArray(sexp) && first(sexp) === "L4" ? parseL4GoodProgramOrExp(first(sexp), rest(sexp)) :
    isArray(sexp) ? parseL4Exp(sexp):
    makeFailure("Unexpected type " + sexp);

const parseL4GoodProgramOrExp = (keyword: Sexp, body: Sexp[]): Result<Parsed> =>
    keyword === "L4" && !isEmpty(body) ? bind(mapResult(parseL4Exp, body),
                                              (exps: Exp[]) => makeOk(makeProgram(exps))) :
    makeFailure("Program must be of the form (L4 <exp>+)");

export const parseL4Exp = (sexp: Sexp): Result<Exp> =>
    isEmpty(sexp) ? makeFailure("Exp cannot be an empty list") :
    isArray(sexp) ? parseL4CompoundExp(first(sexp), rest(sexp)) :
    isToken(sexp) ? parseL4Atomic(sexp) :
    makeFailure("Unexpected type " + sexp);

export const parseL4CompoundExp = (op: Sexp, params: Sexp[]): Result<Exp> => 
    op === "define" ? parseDefine(params) :
    parseL4CompoundCExp(op, params);

export const parseL4CompoundCExp = (op: Sexp, params: Sexp[]): Result<CExp> =>
    isString(op) && isSpecialForm(op) ? parseL4SpecialForm(op, params) :
    parseAppExp(op, params);

export const parseL4SpecialForm = (op: Sexp, params: Sexp[]): Result<CExp> =>
    isEmpty(params) ? makeFailure("Empty args for special form") :
    op === "if" ? parseIfExp(params) :
    op === "lambda" ? parseProcExp(first(params), rest(params)) :
    op === "let" ? parseLetExp(first(params), rest(params)) :
    op === "quote" ? parseLitExp(first(params)) :
    op === "letrec" ? parseLetrecExp(first(params), rest(params)) :
    op === "set!" ? parseSetExp(params) :
    makeFailure("Never");

export const parseDefine = (params: Sexp[]): Result<DefineExp> =>
    isEmpty(params) ? makeFailure("define missing 2 arguments") :
    isEmpty(rest(params)) ? makeFailure("define missing 1 arguments") :
    ! isEmpty(rest(rest(params))) ? makeFailure("define has too many arguments") :
    parseGoodDefine(first(params), second(params));

const parseGoodDefine = (variable: Sexp, val: Sexp): Result<DefineExp> =>
    ! isIdentifier(variable) ? makeFailure("First arg of define must be an identifier") :
    bind(parseL4CExp(val),
         (value: CExp) => makeOk(makeDefineExp(makeVarDecl(variable), value)));

export const parseL4Atomic = (token: Token): Result<CExp> =>
    token === "#t" ? makeOk(makeBoolExp(true)) :
    token === "#f" ? makeOk(makeBoolExp(false)) :
    isString(token) && isNumericString(token) ? makeOk(makeNumExp(+token)) :
    isString(token) && isPrimitiveOp(token) ? makeOk(makePrimOp(token)) :
    isString(token) ? makeOk(makeVarRef(token)) :
    makeOk(makeStrExp(token.toString()));

export const parseL4CExp = (sexp: Sexp): Result<CExp> =>
    isEmpty(sexp) ? makeFailure("CExp cannot be an empty list") :
    isArray(sexp) ? parseL4CompoundCExp(first(sexp), rest(sexp)) :
    isToken(sexp) ? parseL4Atomic(sexp) :
    makeFailure("Unexpected type " + sexp);

/*
    ;; <prim-op>  ::= + | - | * | / | < | > | = | not | and | or | eq? | string=?
    ;;                  | cons | car | cdr | pair? | number? | list
    ;;                  | boolean? | symbol? | string?      ##### L3
*/
const isPrimitiveOp = (x: string): boolean =>
    ["+", "-", "*", "/", ">", "<", "=", "not", "and", "or", 
     "eq?", "string=?", "cons", "car", "cdr", "list", "pair?",
     "list?", "number?", "boolean?", "symbol?", "string?"].includes(x);

const isSpecialForm = (x: string): boolean =>
    ["if", "lambda", "let", "quote", "letrec", "set!"].includes(x);

const parseAppExp = (op: Sexp, params: Sexp[]): Result<AppExp> =>
    safe2((rator: CExp, rands: CExp[]) => makeOk(makeAppExp(rator, rands)))
        (parseL4CExp(op), mapResult(parseL4CExp, params));

const parseIfExp = (params: Sexp[]): Result<IfExp> =>
    params.length !== 3 ? makeFailure("Expression not of the form (if <cexp> <cexp> <cexp>)") :
    bind(mapResult(parseL4CExp, params),
         (cexps: CExp[]) => makeOk(makeIfExp(cexps[0], cexps[1], cexps[2])));

const parseProcExp = (vars: Sexp, body: Sexp[]): Result<ProcExp> =>
    isArray(vars) && allT(isString, vars) ? bind(mapResult(parseL4CExp, body),
                                                 (cexps: CExp[]) => makeOk(makeProcExp(map(makeVarDecl, vars), cexps))) :
    makeFailure(`Invalid vars for ProcExp`);

const isGoodBindings = (bindings: Sexp): bindings is [string, Sexp][] =>
    isArray(bindings) &&
    allT(isArray, bindings) &&
    allT(isIdentifier, map(first, bindings));

const parseBindings = (bindings: Sexp): Result<Binding[]> => {
    if (!isGoodBindings(bindings)) {
        return makeFailure(`Invalid bindings: ${bindings}`);
    }
    const vars = map(b => b[0], bindings);
    const valsResult = mapResult(binding => parseL4CExp(second(binding)), bindings);
    return bind(valsResult,
                (vals: CExp[]) => makeOk(zipWith(makeBinding, vars, vals)));
}

const parseLetExp = (bindings: Sexp, body: Sexp[]): Result<LetExp> =>
    safe2((bindings: Binding[], body: CExp[]) => makeOk(makeLetExp(bindings, body)))
        (parseBindings(bindings), mapResult(parseL4CExp, body));

const parseLetrecExp = (bindings: Sexp, body: Sexp[]): Result<LetrecExp> =>
    safe2((bindings: Binding[], body: CExp[]) => makeOk(makeLetrecExp(bindings, body)))
        (parseBindings(bindings), mapResult(parseL4CExp, body));

const parseSetExp = (params: Sexp[]): Result<SetExp> =>
    isEmpty(params) ? makeFailure("set! missing 2 arguments") :
    isEmpty(rest(params)) ? makeFailure("set! missing 1 argument") :
    ! isEmpty(rest(rest(params))) ? makeFailure("set! has too many arguments") :
    parseGoodSetExp(first(params), second(params));

const parseGoodSetExp = (variable: Sexp, val: Sexp): Result<SetExp> =>
    ! isIdentifier(variable) ? makeFailure("First arg of set! must be an identifier") :
    bind(parseL4CExp(val), (val: CExp) => makeOk(makeSetExp(makeVarRef(variable), val)));

// LitExp has the shape (quote <sexp>)
export const parseLitExp = (param: Sexp): Result<LitExp> =>
    bind(parseSExp(param), (sexp: SExpValue) => makeOk(makeLitExp(sexp)));

export const isDottedPair = (sexps: Sexp[]): boolean =>
    sexps.length === 3 && 
    sexps[1] === "."

export const makeDottedPair = (sexps : Sexp[]): Result<SExpValue> =>
    safe2((val1: SExpValue, val2: SExpValue) => makeOk(makeCompoundSExp(val1, val2)))
        (parseSExp(sexps[0]), parseSExp(sexps[2]));

// x is the output of p (sexp parser)
export const parseSExp = (sexp: Sexp): Result<SExpValue> =>
    sexp === "#t" ? makeOk(true) :
    sexp === "#f" ? makeOk(false) :
    isString(sexp) && isNumericString(sexp) ? makeOk(+sexp) :
    isSexpString(sexp) ? makeOk(sexp.toString()) :
    isString(sexp) ? makeOk(makeSymbolSExp(sexp)) :
    sexp.length === 0 ? makeOk(makeEmptySExp()) :
    isDottedPair(sexp) ? makeDottedPair(sexp) :
    isArray(sexp) ? (
        // fail on (x . y z)
        sexp[0] === '.' ? makeFailure("Bad dotted sexp: " + sexp) : 
        safe2((val1: SExpValue, val2: SExpValue) => makeOk(makeCompoundSExp(val1, val2)))
            (parseSExp(first(sexp)), parseSExp(rest(sexp)))) :
    makeFailure(`Bad literal expression: ${sexp}`);


// ==========================================================================
// Unparse: Map an AST to a concrete syntax string.

// Add a quote for symbols, empty and compound sexp - strings and numbers are not quoted.
const unparseLitExp = (le: LitExp): string =>
    isEmptySExp(le.val) ? `'()` :
    isSymbolSExp(le.val) ? `'${valueToString(le.val)}` :
    isCompoundSExp(le.val) ? `'${valueToString(le.val)}` :
    `${le.val}`;

const unparseLExps = (les: Exp[]): string =>
    map(unparse, les).join(" ");

const unparseProcExp = (pe: ProcExp): string => 
    `(lambda (${map((p: VarDecl) => p.var, pe.args).join(" ")}) ${unparseLExps(pe.body)})`

const unparseBindings = (bdgs: Binding[]): string =>
    map((b: Binding) => `(${b.var.var} ${unparse(b.val)})`, bdgs).join(" ");

const unparseLetExp = (le: LetExp) : string => 
    `(let (${unparseBindings(le.bindings)}) ${unparseLExps(le.body)})`

const unparseLetrecExp = (le: LetrecExp): string => 
    `(letrec (${unparseBindings(le.bindings)}) ${unparseLExps(le.body)})`

const unparseSetExp = (se: SetExp): string =>
    `(set! ${se.var.var} ${unparse(se.val)})`;

export const unparse = (exp: Parsed): string =>
    isBoolExp(exp) ? valueToString(exp.val) :
    isNumExp(exp) ? valueToString(exp.val) :
    isStrExp(exp) ? valueToString(exp.val) :
    isLitExp(exp) ? unparseLitExp(exp) :
    isVarRef(exp) ? exp.var :
    isProcExp(exp) ? unparseProcExp(exp) :
    isIfExp(exp) ? `(if ${unparse(exp.test)} ${unparse(exp.then)} ${unparse(exp.alt)})` :
    isAppExp(exp) ? `(${unparse(exp.rator)} ${unparseLExps(exp.rands)})` :
    isPrimOp(exp) ? exp.op :
    isLetExp(exp) ? unparseLetExp(exp) :
    isLetrecExp(exp) ? unparseLetrecExp(exp) :
    isSetExp(exp) ? unparseSetExp(exp) :
    isDefineExp(exp) ? `(define ${exp.var.var} ${unparse(exp.val)})` :
    isProgram(exp) ? `(L4 ${unparseLExps(exp.exps)})` :
    "";


// Task 2.3
export const L4toMermaid = (concrete: string): Result<string> => 
    bind(bind(parseL4toParsed(concrete), mapL4toMermaid), unparseMermaid);

// Task 2.3
export const unparseMermaid = (exp: Graph): Result<string> =>
    isGraph(exp) ? bind(unparseContentMermaid(exp.content), content =>
    makeOk(`graph ${exp.dir}\n${content}`)):
    makeFailure("illegal Graph")

export const unparseContentMermaid = (exp: GraphContent): Result<string> =>
    isAtomicGraph(exp) ? unparseNodeMermaid(exp):
    isCompoundGraph(exp) ? bind(mapResult(unparseEdgeMermaid, exp),
    strs => makeOk(strs.join("\n"))):
    makeFailure("illegal graph Content");

export const unparseEdgeMermaid = (exp: Edge): Result<string> =>
    isEdge(exp) && typeof(exp.label) === "undefined" ? safe2((from: string, to:string) =>
    makeOk(`${from} --> ${to}`))(unparseNodeMermaid(exp.from), unparseNodeMermaid(exp.to)):

    isEdge(exp) && typeof(exp.label) === "string" ? safe2((from: string, to:string) =>
    makeOk(`${from} -->|${exp.label}| ${to}`))(unparseNodeMermaid(exp.from),unparseNodeMermaid(exp.to)):
    makeFailure("illegal edge");

export const unparseNodeMermaid = (exp: Node): Result<string> =>
    isNodeDecl(exp) ? makeOk(`${exp.id}[${exp.label}]`):
    isNodeRef(exp) ? makeOk(`${exp.id}`):
    makeFailure("illegal node");

// Task 2.2
export const mapL4toMermaid = (exp: Parsed): Result<Graph> => 
    bind(mapL4toGraphContentMermaid(exp),
    (content:GraphContent) => 
        isCompoundGraph(content) ? makeOk(makeGraph(`TD`, cons(makeEdge(makeNodeDecl(content[0].from.id, content[0].from.id.split('_')[0]), content[0].to, content[0].label), content.slice(1)))):
        isAtomicGraph(content) ? makeOk(makeGraph(`TD`, content)):
        makeFailure("illegal expression"));

export const mapL4toGraphContentMermaid = (exp: Parsed): Result<GraphContent> =>
isNumExp(exp) ? makeOk(makeNodeDecl(numExpGen(),`"NumExp(${exp.val})"`)):
isBoolExp(exp) ? makeOk(makeNodeDecl(boolExpGen(), exp.val ? `"BoolExp(#t)"`: `"BoolExp(#f)"`)):
isStrExp(exp) ? makeOk(makeNodeDecl(strExpGen(),`"StrExp(${exp.val})"`)):
isPrimOp(exp) ? makeOk(makeNodeDecl(primOpGen(),`"PrimOp(${exp.op})"`)):
isVarRef(exp) ? makeOk(makeNodeDecl(varRefGen(),`"VarRef(${exp.var})"`)):
isDefineExp(exp) ? mapDefineExptoMermaid(exp):
isSetExp(exp) ? mapSetExptoMermaid(exp):
isLetExp(exp) ? mapLetExptoMermaid(exp):
isLetrecExp(exp) ? mapLetrecExptoMermaid(exp):
isProcExp(exp) ? mapProcExptoMermaid(exp):
isIfExp(exp) ? mapIfExptoMermaid(exp):
isAppExp(exp) ? mapAppExptoMermaid(exp):
isLitExp(exp) ? mapLitExptoMermaid(exp):
isProgram(exp) ? mapProgramtoMermaid(exp):
makeFailure("illegal L4 AST" + exp);

const mapDefineExptoMermaid = (exp: DefineExp): Result<GraphContent> => {
    const defNodeDecl = makeNodeDecl(defineExpGen(), "DefineExp");
    const defNodeRef = makeNodeRef(defNodeDecl.id);
    const varDeclNode = makeNodeDecl(varDeclGen(), `"VarDecl(${exp.var.var})"`);
    const defEdge = makeEdge(defNodeRef, varDeclNode, "var");
    
    const ret = bind(mapL4toGraphContentMermaid(exp.val),
        val => isAtomicGraph(val) ? makeOk([makeEdge(defNodeRef, val, "val")]):
        makeOk(cons(makeEdge(defNodeRef, makeNodeDecl(val[0].from.id, val[0].from.id.split('_')[0]) , "val"), val)));

    return bind(ret, val => makeOk(cons(defEdge, val)));
}
const mapSetExptoMermaid = (exp: SetExp): Result<GraphContent> => {
    const setNodeDecl = makeNodeDecl(setExpGen(), "SetExp");
    const setNodeRef = makeNodeRef(setNodeDecl.id);
    const varNodeDecl = makeNodeDecl(varRefGen(),`"VarRef(${exp.var.var})"`);
    const varNodeRef = makeNodeRef(varNodeDecl.id);
    const varEdge = makeEdge(setNodeRef, varNodeDecl, "var");

    const set = bind(mapL4toGraphContentMermaid(exp.val),
    val => isAtomicGraph(val) ? makeOk([makeEdge(setNodeRef, val, "val")]): 
    makeOk(cons(makeEdge(setNodeRef, makeNodeDecl(val[0].from.id, val[0].from.id.split('_')[0]), "val"), val)));

    return bind(set, val => makeOk(cons(varEdge, val)));
}

const mapLetExptoMermaid = (exp: LetExp): Result<GraphContent> => {
    const letNodeDecl = makeNodeDecl(letExpGen(), "LetExp");
    const letNodeRef = makeNodeRef(letNodeDecl.id);
    const bindingsNodeDecl = makeNodeDecl(bindingsGen(), ":");
    const bindingsNodeRef = makeNodeRef(bindingsNodeDecl.id);
    const bodyNodeDecl = makeNodeDecl(bodyGen(), ":");
    const bodyNodeRef = makeNodeRef(bodyNodeDecl.id);
    const littobindingsEdge = makeEdge(letNodeRef, bindingsNodeDecl, "bindings");
    const bodyEdge = makeEdge(letNodeRef, bodyNodeDecl, "body");

    const bindings = mapResult(x => bind(mapL4toGraphContentMermaid(x.val),
    val => {
        const bindDeclNode =  makeNodeDecl(bindingGen(), `Binding`);
        const bindRefNode = makeNodeRef(bindDeclNode.id);
        const bindEdge = makeEdge(bindingsNodeRef, bindDeclNode);
        return makeOk(
            [bindEdge, makeEdge(bindRefNode, makeNodeDecl(varDeclGen(),`"VarDecl(${x.var.var})"`),"var")] // binding + var
            .concat(isAtomicGraph(val) ? [makeEdge(bindRefNode, val, "val")] :
            cons(makeEdge(bindRefNode, makeNodeDecl(val[0].from.id, val[0].from.id.split('_')[0]), "val"), val))
            )}),exp.bindings);

    const body = bind(mapResult(mapL4toGraphContentMermaid, exp.body),
    vals => makeOk(chain(val => isAtomicGraph(val) ? [makeEdge(bodyNodeRef, val)]: 
    cons(makeEdge(bodyNodeRef, makeNodeDecl(val[0].from.id, val[0].from.id.split('_')[0])), val), vals)));


    return safe2((bindings: Edge[][], body: Edge[]) => 
    makeOk(cons(littobindingsEdge, flatten(bindings)).concat(cons(bodyEdge, body))))
    (bindings, body);
}

const mapLetrecExptoMermaid = (exp: LetrecExp): Result<GraphContent> => {
    const letrecNodeDecl = makeNodeDecl(letrecExpGen(), "LetrecExp");
    const letrecNodeRef = makeNodeRef(letrecNodeDecl.id);
    const bindingsNodeDecl = makeNodeDecl(bindingsGen(), ":");
    const bindingsNodeRef = makeNodeRef(bindingsNodeDecl.id);
    const bodyNodeDecl = makeNodeDecl(bodyGen(), ":");
    const bodyNodeRef = makeNodeRef(bodyNodeDecl.id); 
    const litrectobindingsEdge = makeEdge(letrecNodeRef, bindingsNodeDecl, "bindings");
    const bodyEdge = makeEdge(letrecNodeRef, bodyNodeDecl, "body");

    const bindings = mapResult(x => bind(mapL4toGraphContentMermaid(x.val),
    val => {
        const bindDeclNode =  makeNodeDecl(bindingGen(), `Binding`);
        const bindRefNode = makeNodeRef(bindDeclNode.id);
        const bindEdge = makeEdge(bindingsNodeRef, bindDeclNode);
        return makeOk(
            [bindEdge, makeEdge(bindRefNode, makeNodeDecl(varDeclGen(),`"VarDecl(${x.var.var})"`),"var")] // binding + var
            .concat(isAtomicGraph(val) ? [makeEdge(bindRefNode, val, "val")] :
            cons(makeEdge(bindRefNode, makeNodeDecl(val[0].from.id, val[0].from.id.split('_')[0]), "val"), val))
            )}),exp.bindings);

    const body = bind(mapResult(mapL4toGraphContentMermaid, exp.body),
        vals => makeOk(chain(val => isAtomicGraph(val) ? [makeEdge(bodyNodeRef, val)]: 
        cons(makeEdge(bodyNodeRef, makeNodeDecl(val[0].from.id, val[0].from.id.split('_')[0])), val), vals)));
    
    
    return safe2((bindings: Edge[][], body: Edge[]) => 
    makeOk(cons(litrectobindingsEdge, flatten(bindings)).concat(cons(bodyEdge, body))))
    (bindings, body);
}

const mapProcExptoMermaid = (exp: ProcExp): Result<GraphContent> => {
    const procNodeDecl = makeNodeDecl(procExpGen(),"ProcExp");
    const procNodeRef = makeNodeRef(procNodeDecl.id);
    const paramsNodeDecl = makeNodeDecl(paramsGen(), ":");
    const paramsNodeRef = makeNodeRef(paramsNodeDecl.id);
    const bodyNodeDecl = makeNodeDecl(bodyGen(), ":");
    const bodyNodeRef = makeNodeRef(bodyNodeDecl.id);

    const paramsEdge = makeEdge(procNodeRef, paramsNodeDecl, "args");
    const bodyEdge = makeEdge(procNodeRef, bodyNodeDecl, "body");

    const params = makeOk(map(x => makeEdge(paramsNodeRef,makeNodeDecl(varDeclGen(),`"VarDecl(${x.var})"`)), exp.args));

    const body = bind(mapResult(mapL4toGraphContentMermaid, exp.body),
    vals => makeOk(chain(val => isAtomicGraph(val) ? [makeEdge(bodyNodeRef, val)]: 
    cons(makeEdge(bodyNodeRef, makeNodeDecl(val[0].from.id, val[0].from.id.split('_')[0])), val), vals)));

    return safe2((params: Edge[], body: Edge[]) => 
    makeOk(cons(paramsEdge,params).concat(cons(bodyEdge, body))))
    (params, body);
}

const mapLitExptoMermaid = (exp: LitExp): Result<GraphContent> => {
    const litNodeDecl = makeNodeDecl(litExpGen(), "LitExp");
    const litNodeRef = makeNodeRef(litNodeDecl.id);
    return bind(mapSExpValuetoMermaid(exp.val), exp => isAtomicGraph(exp) ? makeOk([makeEdge(litNodeRef, exp, "val")]): 
    makeOk(cons(makeEdge(litNodeRef, makeNodeDecl(exp[0].from.id, `"${exp[0].from.id.split('_')[0]}"`), "val"), exp)));
}

const mapSExpValuetoMermaid = (exp: SExpValue): Result<GraphContent> => 
    isNumber(exp) ? makeOk(makeNodeDecl(numberGen(),`"number(${exp.toString()})"`)):
    isBoolean(exp) ? makeOk(makeNodeDecl(booleanGen(), exp ? `"boolean(#t)"`: `"boolean(#f)"`)):
    isString(exp) ? makeOk(makeNodeDecl(stringGen(),`"string(${exp.toString()})"`)):
    isPrimOp(exp) ? makeOk(makeNodeDecl(primOpGen(),`"PrimOp(${exp.op})"`)):
    isEmptySExp(exp) ? makeOk(makeNodeDecl(emptySExpGen(),`"EmptySExp"`)):
    isSymbolSExp(exp) ? makeOk(makeNodeDecl(symbolSexpGen(),`"SymbolSExp(${exp.val})"`)):
    isCompoundSExp(exp) ? compoundSExptoMermaid(exp):
    makeFailure("illegal expression");

const compoundSExptoMermaid = (exp: CompoundSExp): Result<GraphContent> => {
    const compoundSExpNodeDecl = makeNodeDecl(compoundSexpGen(),`"CompoundSExp"`);
    const compoundSExpNodeRef = makeNodeRef(compoundSExpNodeDecl.id);

    const vals1 = bind(mapSExpValuetoMermaid(exp.val1),
    val => isAtomicGraph(val) ? makeOk([makeEdge(compoundSExpNodeRef, val, "val1")]): 
    makeOk(cons(makeEdge(compoundSExpNodeRef, makeNodeDecl(val[0].from.id, `"${val[0].from.id.split('_')[0]}"`), "val1"), val)));

    const vals2 = bind(mapSExpValuetoMermaid(exp.val2),
    val => isAtomicGraph(val) ? makeOk([makeEdge(compoundSExpNodeRef, val, "val2")]): 
    makeOk(cons(makeEdge(compoundSExpNodeRef, makeNodeDecl(val[0].from.id, `"${val[0].from.id.split('_')[0]}"`), "val2"), val))); 

    return safe2((vals1: Edge[], vals2: Edge[]) => 
    makeOk(vals1.concat(vals2)))
    (vals1, vals2)
}

const mapProgramtoMermaid = (exp: Program): Result<GraphContent> => {
    const progNodeDecl = makeNodeDecl(progGen(), "Program");
    const progNodeRef = makeNodeRef(progNodeDecl.id);
    const expsNodeDecl = makeNodeDecl(expsGen(), ":");
    const expsNodeRef = makeNodeRef(expsNodeDecl.id);
    const progEdge = makeEdge(progNodeRef, expsNodeDecl, "exps");

    const ret = bind(mapResult(mapL4toGraphContentMermaid, exp.exps),
        vals => makeOk(chain(val => isAtomicGraph(val) ? [makeEdge(expsNodeRef, val)]: 
        cons(makeEdge(expsNodeRef, makeNodeDecl(val[0].from.id, val[0].from.id.split('_')[0])), val), vals)));

    return bind(ret, vals => makeOk(cons(progEdge, vals)));
}

const mapIfExptoMermaid = (exp: IfExp): Result<GraphContent> => {
    const ifNodeDecl = makeNodeDecl(ifExpGen(), "IfExp");
    const ifNodeRef = makeNodeRef(ifNodeDecl.id);

    const test =  bind(mapL4toGraphContentMermaid(exp.test),
    val => isAtomicGraph(val) ? makeOk([makeEdge(ifNodeRef, val, "test")]): 
    makeOk(cons(makeEdge(ifNodeRef, makeNodeDecl(val[0].from.id, val[0].from.id.split('_')[0]), "test"), val)));

    const then =  bind(mapL4toGraphContentMermaid(exp.then),
    val => isAtomicGraph(val) ? makeOk([makeEdge(ifNodeRef, val, "then")]): 
    makeOk(cons(makeEdge(ifNodeRef, makeNodeDecl(val[0].from.id, val[0].from.id.split('_')[0]), "then"), val)));

    const alt =  bind(mapL4toGraphContentMermaid(exp.alt),
    val => isAtomicGraph(val) ? makeOk([makeEdge(ifNodeRef, val, "alt")]): 
    makeOk(cons(makeEdge(ifNodeRef, makeNodeDecl(val[0].from.id, val[0].from.id.split('_')[0]), "alt"), val)));

    return safe3((test: Edge[], then: Edge[], alt: Edge[]) => 
    makeOk(test.concat(then).concat(alt)))
    (test, then, alt);
}

const mapAppExptoMermaid = (exp: AppExp): Result<GraphContent> => {
    const appNodeDecl = makeNodeDecl(appExpGen(), "AppExp");
    const appNodeRef = makeNodeRef(appNodeDecl.id);
    const appNodeRands = makeNodeDecl(randsGen(), ":");
    const appNodeRefRands = makeNodeRef(appNodeRands.id);
    const randsEdge = makeEdge(appNodeRef, appNodeRands, "rands");

    const rator = bind(mapL4toGraphContentMermaid(exp.rator), 
        val => isAtomicGraph(val) ? makeOk([makeEdge(appNodeRef, val, "rator")]):   // primOp case
                makeOk(cons(makeEdge(appNodeRef, makeNodeDecl(val[0].from.id, val[0].from.id.split('_')[0]), "rator"), val)));     // ProcExp case

    const rands = bind(mapResult(mapL4toGraphContentMermaid, exp.rands),
        vals => makeOk(chain(val => isAtomicGraph(val) ? [makeEdge(appNodeRefRands, val)]: 
        cons(makeEdge(appNodeRefRands, makeNodeDecl(val[0].from.id, val[0].from.id.split('_')[0])), val), vals)));

    return safe2((rator: Edge[], rands: Edge[]) => 
    makeOk(rator.concat(randsEdge).concat(rands)))
    (rator, rands);
}