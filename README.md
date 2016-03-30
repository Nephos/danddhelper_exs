# danddhelper_exs

*Dungeons and Dragons Helper -- in Elixir lang*

# Usage

```sh
./run [opti]
```

## Commands for Roll mode (default)

You can use the following commands:

- ``ROLL``: roll the command
- ``NAME ROLL``: save the roll with a name
- ``delete NAME``: remove a saved named roll
- *empty line*: roll every saved rolls

### Example

> Input a roll: 1d6
>
> 1D6 ... 5 = 5
>
>
>
> Input a roll: 1d6 + 4
>
> 1D6 + 4 ... 4, 2 = 6
>
>
>
> Input a roll: toto 1d20 + 6
>
> 1D20 + 6 ... 6, 1 = 7
>
>
>
> Input a roll: lobo 1d20 + 1
>
> 1D20 + 1 ... 1, 14 = 15
>
>
>
> Input a roll:
>
>
>
> \*\*\*\*\* lobo \*\*\*\*\*	 1D20 + 1 ... 1, 14 = 15
>
> \*\*\*\*\* toto \*\*\*\*\*	 1D20 + 6 ... 6, 7 = 13
>
>
>
> Input a roll: delete lobo
>
> \*\*\*\*\* Deleted lobo \*\*\*\*\*
>
>
>
> Input a roll: robo 1d20 + 2
>
> 1D20 + 2 ... 2, 20 = 22
>
>
>
> Input a roll: robo 1d20 + 3
>
> 1D20 + 3 ... 3, 17 = 20
>
>
>
> Input a roll:
>
>
>
> \*\*\*\*\* robo \*\*\*\*\*	 1D20 + 3 ... 3, 3 = 6
>
> \*\*\*\*\* toto \*\*\*\*\*	 1D20 + 6 ... 6, 19 = 25
>
>
>
> Input a roll: exit
>

## Commands for Opti mode

*Computes the damages you can inflict based on the average accuracy of the attacks.*

You can use the following commands:

- max: maximum damages inflicted in one round
- min: minimum damages inflicted in one round
- mean: average damages inflicted in one round

### Todo

- handle critical damages and fumble cases

### Example

> Input a command: max 20 14/14/7 5d6+5+19
>
> [max] attacks: 0.7 / 0.7 / 0.35, with 5D6 + 5 + 19 damages => 37.8 + 37.8 + 18.9 => 94.5
>
>
>
> Input a command: max 10 14/14/7 5d6+5+19
>
> [max] attacks: 1.0 / 1.0 / 0.85, with 5D6 + 5 + 19 damages => 54.0 + 54.0 + 45.9 => 153.9
>
>
>
> Input a command: mean 20 14/14/7 5d6+5+19
>
> [mean] attacks: 0.7 / 0.7 / 0.35, with 5D6 + 5 + 19 damages => 29.05 + 29.05 + 14.53 => 72.63
>
>
>
> Input a command: exit
>
