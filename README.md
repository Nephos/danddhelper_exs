# danddhelper_exs

*Dungeons and Dragons Helper -- in Elixir lang*

# Usage

```sh
rlwrap ./run
```

## Commands

You can use the following commands:

- ``ROLL``: roll the command
- ``NAME ROLL``: save the roll with a name
- ``delete NAME``: remove a saved named roll
- *empty line*: roll every saved rolls

## Example

> Input a roll: 1d6
> 1D6 ... 5 = 5
>
> Input a roll: 1d6 + 4
> 1D6 + 4 ... 4, 2 = 6
>
> Input a roll: toto 1d20 + 6
> 1D20 + 6 ... 6, 1 = 7
>
> Input a roll: lobo 1d20 + 1
> 1D20 + 1 ... 1, 14 = 15
>
> Input a roll: 
>
> \*\*\*\*\* lobo \*\*\*\*\*	 1D20 + 1 ... 1, 14 = 15
> \*\*\*\*\* toto \*\*\*\*\*	 1D20 + 6 ... 6, 7 = 13
>
> Input a roll: delete lobo
> \*\*\*\*\* Deleted lobo \*\*\*\*\*
>
> Input a roll: robo 1d20 + 2
> 1D20 + 2 ... 2, 20 = 22
>
> Input a roll: robo 1d20 + 3
> 1D20 + 3 ... 3, 17 = 20
>
> Input a roll:
>
> \*\*\*\*\* robo \*\*\*\*\*	 1D20 + 3 ... 3, 3 = 6
> \*\*\*\*\* toto \*\*\*\*\*	 1D20 + 6 ... 6, 19 = 25
>
> Input a roll: exit
