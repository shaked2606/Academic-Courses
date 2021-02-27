// ===========================================================
// AST type models
import { map, zipWith } from "ramda";
import { Sexp, Token } from "s-expression";
import { allT, first, second, rest, isEmpty } from "../shared/list";
import { isArray, isString, isNumericString, isIdentifier } from "../shared/type-predicates";
import { parse as p, isSexpString, isToken } from "../shared/parser";
import { Result, makeOk, makeFailure, bind, mapResult, safe2 } from "../shared/result";
import { isSymbolSExp, isEmptySExp, isCompoundSExp } from './L4-value';
import { makeEmptySExp, makeSymbolSExp, SExpValue, makeCompoundSExp, valueToString } from './L4-value'

/*

<graph> ::= <header> <graphContent> // Graph(dir: Dir, content: GraphContent)
<header> ::= graph (TD|LR)<newline> // Direction can be TD or LR
<graphContent> ::= <atomicGraph> | <compoundGraph>
<atomicGraph> ::= <nodeDecl>
<compoundGraph> ::= <edge>+

<edge> ::= <node> --><edgeLabel>? <node><newline> // <edgeLabel> is optional
                                                // Edge(from: Node, to: Node, label?: string)
<node> ::= <nodeDecl> | <nodeRef>
<nodeDecl> ::= <identifier>["<string>"] // NodeDecl(id: string, label: string)
<nodeRef> ::= <identifier> // NodeRef(id: string)
<edgeLabel> ::= |<identifier>| // string
*/

// Task 2.1
export type GraphContent = AtomicGraph | CompoundGraph;
export type AtomicGraph = NodeDecl;
export type CompoundGraph = Edge[];
export type Node = NodeDecl | NodeRef;
export type Dir = "TD" | "LR";

export interface Graph {tag:"Graph", dir: Dir, content: GraphContent};
export interface Edge {tag:"Edge", from: Node, to:Node, label?: string};
export interface NodeDecl {tag:"NodeDecl", id:string, label: string};
export interface NodeRef {tag:"NodeRef", id: string};

// Type value constructors for disjoint types
export const makeGraph = (dir: Dir, content:GraphContent): Graph =>({tag: "Graph", dir: dir,content: content});
export const makeEdge = (from: Node,to:Node, label?: string): Edge => ({tag: "Edge", from: from,to:to, label: label});
export const makeNodeDecl = (id:string,  label: string): NodeDecl => ({tag: "NodeDecl", id: id, label: label});
export const makeNodeRef = (id:string): NodeRef => ({tag: "NodeRef", id: id});

export const isGraphContent = (x: any): x is GraphContent => isAtomicGraph(x) || isCompoundGraph(x);
export const isAtomicGraph = (x: any): x is AtomicGraph => isNodeDecl(x);
export const isCompoundGraph = (x: any): x is CompoundGraph => Array.isArray(x) && allT(isEdge, x);
export const isNode = (x: any): x is Node => isNodeDecl(x) || isNodeRef(x);

export const isGraph = (x: any): x is Graph => x.tag === "Graph";
export const isEdge = (x: any): x is Edge => x.tag === "Edge";
export const isNodeDecl = (x: any): x is NodeDecl => x.tag === "NodeDecl";
export const isNodeRef = (x: any): x is NodeRef => x.tag === "NodeRef";