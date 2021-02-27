// Q3.1
// support both signatures of possible options 
export function* braid(generator1:Generator | (() => Generator), generator2:Generator | (() => Generator)): Generator {
    if(isGenerator(generator1) && isGenerator(generator2)){
        while(true){
            var gen1 = generator1.next();
            var gen2 = generator2.next();
            if(gen1.done && gen2.done){
                break;
            }

            if(!gen1.done){
                yield gen1.value;
            }
            if(!gen2.done){
                yield gen2.value;
            }
        }
    }
    else if(isGeneratorFunction(generator1) && isGeneratorFunction(generator2)){
        var gener1 = generator1();
        var gener2 = generator2();
        while(true){
            var gene1 = gener1.next();
            var gene2 = gener2.next();
            if(gene1.done && gene2.done){
                break;
            }
            if(!gene1.done){
                yield gene1.value;
            }
            if(!gene2.done){
                yield gene2.value;
            }
        }
    }
}

// Q3.2
// support both signatures of possible options 
export function* biased(generator1:Generator | (() => Generator), generator2:Generator | (() => Generator)): Generator {
    if(isGenerator(generator1) && isGenerator(generator2)){
        while(true){
            var gen1 = generator1.next();
            var gen1_2 = generator1.next();
            var gen2 = generator2.next();
            if(gen1.done && gen1_2.done && gen2.done){
                break;
            }
            if(!gen1.done){
                yield gen1.value;
            }
            if(!gen1_2.done){
                yield gen1_2.value;
            }
            if(!gen2.done){
                yield gen2.value;
            }
        }
    }
    else if(isGeneratorFunction(generator1) && isGeneratorFunction(generator2)){
        var gener1 = generator1();
        var gener2 = generator2();
        while(true){
            var gene1 = gener1.next();
            var gene1_2 = gener1.next();
            var gene2 = gener2.next();
            if(gene1.done && gene1_2.done && gene2.done){
                break;
            }
            if(!gene1.done){
                yield gene1.value;
            }
            if(!gene1_2.done){
                yield gene1_2.value;
            }
            if(!gene2.done){
                yield gene2.value;
            }
        }
    }

}

// type predicates 
const isGeneratorFunction = (x: any): x is (() => Generator) => x.constructor.name === "GeneratorFunction";
const isGenerator = (x: any): x is Generator => !isGeneratorFunction(x);


function* gen1() {
    yield 3;
    yield 6;
    yield 9;
    yield 12;
}
function* gen2() {
    yield 8;
    yield 10;
}

export function* take(n:number, generator:Generator) {
    for (let v of generator) {
    if (n <= 0) return;
        n--;
    yield v;
    }
}

// for (let n of take(20, braid(gen1(), gen2()))){
//     console.log(n);
// }
// 3, 8, 6, 10

// for (let n of take(4, biased(gen1,gen2))) {
//     console.log(n);
// }
// 3, 6, 8, 9
    

