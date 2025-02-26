# Go_Park
## 1) Features:
1. Automatic transfer of cars to and from the garage without any human intervention.
2. Make a payment invoice according to the period spent by the car inside the garage
## 2) algo:
### input => Process => Output
enterPulse   |  searching algorithm
isElv_1_Empty
grage places[ ]=true
time count [ ]
exitPulse[]
```mermaid
graph LR

    A[enterPulse];

    A-->start_button
    A-->flutter_app
    A-->Touch_screen
    A-->sensor

```
### Logic to Enter the Garage
```mermaid
flowchart TB
A([start])==>B[/apply enterPulse/]
B==>C{is there an elevator empty?}
C==NO==>D[/there is no empty elevator try again later/]
C==yes==>E[Searching Algorithm]
E==>F{empty place is founded?}
F==No ==>G[sorry no place empty]
F==Yes==>H[apply motion to motors to move the car to it's place]
H==>I[grage place key=false ]
I==>J[Start time count]
J==>K([End])
```
### Logic to Exit the Garage

```mermaid
flowchart TB
A([start])==>B[/apply exitPulse/]
B==>C{is there an elevator empty?}
C==NO==>D[/there is no empty elevator try again later/]
C==yes==>E{at this key there is a car?}
E==NO==>F[there is no car here]
E==Yes==>G[apply motion to motors to move the car outside]
G==>H[grage place key=true ]
H==>I[End time count]
I==>J[/Show payment invoice to user/]

```

