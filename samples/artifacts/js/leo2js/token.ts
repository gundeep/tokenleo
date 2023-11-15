import {
	token, tokenLeo,
} from "../types"
import { u8, u16, u32, u128, u64, i8, i16, i32, i64, i128, field, scalar, group, boolean, address } from "./common";

export function gettoken(token: tokenLeo) : token {
	const result: token = {
		owner: address(token.owner),
		amount: u64(token.amount),
	}
	return result;
}

