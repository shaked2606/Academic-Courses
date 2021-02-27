import { expect } from "chai";
import * as R from 'ramda'
import { Optional } from "../src/part3/optional"
import { makeNone } from "../src/part3/optional"
import { makeSome } from "../src/part3/optional"
import { isSome } from "../src/part3/optional"
import { isNone } from "../src/part3/optional"
import { bind } from "../src/part3/optional"
import { Result } from "../src/part3/result"
import { monadicValidateUser } from "../src/part3/result"
import { naiveValidateUser } from "../src/part3/result"
const safeDiv = (x: number, y: number): Optional<number> =>
    y === 0 ? makeNone() : makeSome(x / y);
const div10 = (y: number): Optional<number> =>
    y === 0 ? makeNone() : makeSome(10 / y);

describe("make Some/None", () => {
    it("composes many functions", () => {

        expect(safeDiv(5, 0)).to.deep.equal({ tag: "None" });
    })
    it("composes many functions", () => {

        expect(safeDiv(5, 2)).to.deep.equal({ tag: "Some", value: 2.5 });
    })

});

describe("bind", () => {
    it("composes many functions", () => {
        expect(bind(safeDiv(5, 0), div10)).to.deep.equal({ tag: "None" });
    })
    it("composes many functions", () => {
        expect(bind(safeDiv(5,2), div10)).to.deep.equal({ tag: "Some",value:4 });
    })
});

describe("is Some/None", () => {
    it("checks type of None if is Some", () => {

        expect(isSome(safeDiv(5, 0))).to.equal(false);
    })
    it("checks type of Some if is Some", () => {

        expect(isSome(safeDiv(5, 2))).to.equal(true);
    })
    it("checks type of None if is None", () => {

        expect(isNone(safeDiv(5, 0))).to.equal(true);
    })
    it("checks type of some if is none", () => {

        expect(isNone(safeDiv(5, 2))).to.equal(false);
    })
    it("checks type of number", () => {

        expect(isNone(makeSome(3))).to.equal(false);
    })
    it("checks type of number", () => {

        expect(isSome(makeNone())).to.equal(false);
    })
})
const user1 = { name: "Ben", email: "bene@post.bgu.ac.il", handle: "bene" };
const user2 = { name: "Bananas", email: "me@bananas.com", handle: "bene" };
const user3 = { name: "yuval", email: "me@bananas.com", handle: "bene" };
const user4 = { name: "yuval", email: "me@bananas.com", handle: "" };
const user5 = { name: "yuval", email: "me@gmail.com", handle: "" };
const user6 = { name: "yuval", email: "me@gmail.com", handle: "@jubelsM" };

describe("monadic validate user", () => {
    it("validates user data with bind", () => {
        expect(monadicValidateUser(user1)).to.deep.equal({
            tag: 'Ok',
            value: {
                name: 'Ben',
                email: 'bene@post.bgu.ac.il',
                handle: 'bene'
            }
        })
    })

    it("validates user data with bind", () => {
        expect(monadicValidateUser(user2)).to.deep.equal({
            tag: 'Failure',
            message: 'Bananas is not a name'
        })
    })
    it("validates user data with bind", () => {
        expect(monadicValidateUser(user3)).to.deep.equal({
            tag: 'Failure',
            message: "Domain bananas.com is not allowed"
        })
    })
    it("validates user data with bind", () => {
        expect(monadicValidateUser(user4)).to.deep.equal({
            tag: 'Failure',
            message: "Domain bananas.com is not allowed"
        })
    })
    it("validates user data with bind", () => {
        expect(monadicValidateUser(user5)).to.deep.equal({
            tag: 'Failure',
            message: "Handle cannot be empty"
        })
    })
    it("validates user data with bind", () => {
        expect(monadicValidateUser(user6)).to.deep.equal({
            tag: 'Failure',
            message: "This isn't Twitter"
        })
    })
})

describe("naive validate user", () => {
    it("validates user1 data  naively", () => {
        expect(naiveValidateUser(user1)).to.deep.equal({
            tag: 'Ok',
            value: {
                name: 'Ben',
                email: 'bene@post.bgu.ac.il',
                handle: 'bene'
            }
        })
    })

    it("validates user2 data naively", () => {
        expect(naiveValidateUser(user2)).to.deep.equal({
            tag: 'Failure',
            message: 'Bananas is not a name'
        })
    })

    it("validates user3 data naively", () => {
        expect(naiveValidateUser(user3)).to.deep.equal({
            tag: 'Failure',
            message: "Domain bananas.com is not allowed"
        })
    })
    it("validates user6 data naively", () => {
        expect(naiveValidateUser(user6)).to.deep.equal({
            tag: 'Failure',
            message: "This isn't Twitter"
        })
    })})




    ;