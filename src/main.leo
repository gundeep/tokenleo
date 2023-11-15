// The 'token_25644' program.
program token_25644.aleo {
    record Token {
        owner: address,
        balance: u64,
    }
    
    mapping balance: address => u64;

    transition mint (amount: u64) -> Token {
        return Token {
            owner: self.caller,
            balance: amount,
        };
    }

    transition transfer_private (receiver: address, amount: u64, input: Token) -> (Token, Token)  {
        let remaining: u64 = input.balance - amount;

        let caller: Token = Token {
            owner: self.caller,
            balance: remaining,
        };

        let receipent: Token = Token {
            owner: receiver,
            balance: amount,
        };

        return (caller, receipent);
    }

    transition transfer_private_to_public (reciever: address, amount:u64, input:Token) ->  Token 
    { 
        let remaining: u64 = input.balance - amount;
        let caller: Token = Token { owner: self.caller, balance: remaining, };

        return caller then finalize (receiver, amount);
    }
// anything passed to finalize will be publicly shown. 
    finalize transfer_private_to_public (receiver: address, amount: u64) {
        let prev: u64 = Mapping::get_or_use(balance, receiver , 0u64);

        Mapping::set(balance, receiver , prev + amount);
    }

    finalize transfer_public_to_private (caller: address, amount: u64)
    {
        let prev: u64 = Mapping::get(balance, caller);
        Mapping::set(balance, caller , prev - amount);
    }
}
