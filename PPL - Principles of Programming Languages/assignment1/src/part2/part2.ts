import * as R from 'ramda'; 

/* Question 1 */
export const partition = <T>(pred: ((x: T) => boolean), arr: Array<T>):(Array<Array<T>>)=>{
    let arr1: Array<T> = R.filter(pred, arr);
    let arr2: Array<T> = R.filter((x:T) => !pred(x), arr);
    return R.concat([arr1],[arr2]);
};

/* Question 2 */
export const mapMat = <T,U>(func: ((x:T)=>U), mat: Array<Array<T>>):(Array<Array<U>>)=>{
    let new_mat:Array<Array<U>> = R.map((x:Array<T>)=>(R.map(func, x)), mat);
    return new_mat;
};

/* Question 3 */
export const composeMany = <T>(fns: Array<(x:T)=>T>):((x:T)=>T)=>{
    return (x:T) => R.reduceRight((currf:(x:T)=>T, acc:T)=> currf(acc), x, fns);
};

/* Question 4 */
interface Languages {
    english: string;
    japanese: string;
    chinese: string;
    french: string;
}

interface Stats {
    HP: number;
    Attack: number;
    Defense: number;
    "Sp. Attack": number;
    "Sp. Defense": number;
    Speed: number;
}

interface Pokemon {
    id: number;
    name: Languages;
    type: string[];
    base: Stats;
}

export const maxSpeed = (arr: Pokemon[]):(Pokemon[])=>{
    let max:number = R.reduce((acc:number, cur:Pokemon)=> Math.max(acc, cur.base.Speed), 0, arr);
    let fastest:Pokemon[] = R.filter(x=>x.base.Speed === max, arr);
    return fastest;
};

export const grassTypes = (arr: Pokemon[]):(string[])=>{
    let arr1 = R.filter((x:Pokemon)=>R.includes("Grass", x.type), arr)
    return R.map((x:Pokemon)=>x.name.english, arr1).sort();
};

export const uniqueTypes = (arr: Pokemon[]):(string[])=>{
    let arr1 = R.map(x=>x.type, arr);
    let arr2 = R.reduce((acc: Array<string>, curr: Array<string>)=>R.concat(curr, acc), [], arr1);
    let arr3 = R.reduce((acc: Array<string>, cur: string)=>R.includes(cur, acc) ? acc : R.concat([cur], acc),[], arr2).sort();
    return arr3;
};