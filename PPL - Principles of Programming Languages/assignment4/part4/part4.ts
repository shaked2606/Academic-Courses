// Q4.1.a
export function f (x:number):Promise<number> {
    return new Promise<number>((resolve,reject) => {
        (x === 0) ? reject("devision by zero in f function") :
        (!isFinite(x)) ? reject("can't compute infinity in f function"):
        (isNaN(x)) ? reject("number can't be NaN"):
        resolve(1/x);
    });
}

export function g (x:number):Promise<number>{
    return new Promise<number>((resolve,reject) => {
        (isNaN(x)) ? reject("number can't be NaN"):
        (!isFinite(x)) ? reject("can't compute infinity in g function"):
        resolve(x*x);
    });
}

export function h (x:number): Promise<number> {
    return g(x).then(f).catch((err) => Promise.reject(err));
}

// const fpromise = h(0);
// fpromise.then(content => console.log(content)).catch(err => console.log(err));

//Q.4.2
export function slower<T1, T2>(promises: [Promise<T1>, Promise<T2>]): Promise<[number, string]> {
    const [p1, p2] = promises;
    return new Promise<[number, string]>((resolve, reject) => { 
        Promise.race([p1, p2]).then((value) => {
            Promise.all([p1, p2]).then((values) => {
                values[0] === value ? resolve([1, `${values[1]}`]) :
                resolve([0, `${values[0]}`]);
            })}).catch((err) => reject(err));
    });
}

// const p1 = new Promise((resolve, reject) => {
//     setTimeout(resolve, 500, 'one');
//   });
  
//   const p2 = new Promise((resolve, reject) => {
//     setTimeout(resolve, 100, 'two');
//   });

// slower([p1,p2]).then((value) => console.log(value)).catch((err) => console.log(err));
// const timeoutPromise = <T>(value: T, timeout: number): Promise<T> =>
//   new Promise<T>((resolve) => setTimeout(() => resolve(value), timeout));

// slower([Promise.reject("foo"), timeoutPromise("one", 500)])
//   .then(([n, s]) => console.log(`(${n}, ${s})`))
//   .catch((err) => console.error("Error:", err));

//   slower([timeoutPromise("one", 100), timeoutPromise("two", 500)])
//   .then(([n, s]) => console.log(`(${n}, ${s})`))
//   .catch((err) => console.error("Error:", err));