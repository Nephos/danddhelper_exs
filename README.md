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

- average_attack: set or display the average roll of an attack (on a d20)
- max: maximum damages inflicted in one round
- min: minimum damages inflicted in one round
- mean: average damages inflicted in one round

### Todo

- handle critical damages and fumble cases

### Example

> Input a command: max 25 16/16/9 5d6+5+15
>
> [max] attacks: 0.6 / 0.6 / 0.25, with 5D6 + 5 + 15 damages => 30.0 + 30.0 + 12.5 => 72.5
>
>
>
> Input a command: mean 25 16/16/9 5d6+5+15
>
> [mean] attacks: 0.6 / 0.6 / 0.25, with 5D6 + 5 + 15 damages => 22.5 + 22.5 + 9.38 => 54.38
>
>
>
> Input a command: min 25 16/16/9 5d6+5+15
>
> [min] attacks: 0.6 / 0.6 / 0.25, with 5D6 + 5 + 15 damages => 15.0 + 15.0 + 6.25 => 36.25
>
>
>
> Input a command: average_attack = 12
>
> Set average_attack = 60.0 %
>
>
>
> Input a command: min 25 16/16/9 5d6+5+15
>
> [min] attacks: 0.75 / 0.75 / 0.4, with 5D6 + 5 + 15 damages => 18.75 + 18.75 + 10.0 => 47.5
>
>
>
> Input a command: average_attack
>
> Current average attack roll : 12.0 (60.0 %)
>
>
>
> Input a command: exit
>
