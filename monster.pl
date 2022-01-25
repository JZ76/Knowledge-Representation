%those are different types in this game.
type(fire).
type(grass).
type(water).
type(electric).
type(normal).

%there are 5 kinds of monsters in this game.
monster(charmander,fire).
monster(bulbasaur,grass).
monster(squirtle,water).
monster(pikachu,electric).
monster(eevee,normal).

%there are many abilities, and they belong to different types.
ability(scratch,normal).
ability(fireFang,fire).
ability(firePunch,fire).
ability(thunderPunch,electric).
ability(tackle,normal).
ability(vineWhip,grass).
ability(razorLeaf,grass).
ability(solarBeam,grass).
ability(waterPulase,water).
ability(aquaTail,water).
ability(bodySlam,normal).
ability(surf,water).
ability(grassKnot,grass).
ability(thunderbolt,electric).
ability(rainDance,water).
ability(sunnyDay,fire).
ability(bite,normal).
ability(lastResort,normal).

%most of abilities are unique to one kind of monster.
monsterAbility(charmander,scratch).
monsterAbility(charmander,fireFang).
monsterAbility(charmander,firePunch).
monsterAbility(charmander,thunderPunch).
monsterAbility(bulbasaur,tackle).
monsterAbility(bulbasaur,vineWhip).
monsterAbility(bulbasaur,razorLeaf).
monsterAbility(bulbasaur,solarBeam).
monsterAbility(squirtle,tackle).
monsterAbility(squirtle,waterPulse).
monsterAbility(squirtle,aquaTail).
monsterAbility(squirtle,bodySlam).
monsterAbility(pikachu,thunderPunch).
monsterAbility(pikachu,surf).
monsterAbility(pikachu,grassKnot).
monsterAbility(pikachu,thunderbolt).
monsterAbility(eevee,rainDance).
monsterAbility(eevee,sunnyDay).
monsterAbility(eevee,bite).
monsterAbility(eevee,lastResort).

/*
 * different kind of types have three effectiveness to against different types,
 * which are weak, ordinary and super, this could make game become more challenge and interesting.
 */ 
typeEffectiveness(normal,fire,ordinary).
typeEffectiveness(normal,water,ordinary).
typeEffectiveness(normal,electric,ordinary).
typeEffectiveness(normal,grass,ordinary).
typeEffectiveness(normal,normal,ordinary).
typeEffectiveness(fire,fire,weak).
typeEffectiveness(fire,water,weak).
typeEffectiveness(fire,electric,ordinary).
typeEffectiveness(fire,grass,super).
typeEffectiveness(fire,normal,ordinary).
typeEffectiveness(water,fire,super).
typeEffectiveness(water,water,weak).
typeEffectiveness(water,electric,ordinary).
typeEffectiveness(water,grass,weak).
typeEffectiveness(water,normal,ordinary).
typeEffectiveness(electric,fire,ordinary).
typeEffectiveness(electric,water,super).
typeEffectiveness(electric,electric,weak).
typeEffectiveness(electric,grass,weak).
typeEffectiveness(electric,normal,ordinary).
typeEffectiveness(grass,fire,weak).
typeEffectiveness(grass,water,super).
typeEffectiveness(grass,electric,ordinary).
typeEffectiveness(grass,grass,weak).
typeEffectiveness(grass,normal,ordinary).

%the first rule is creat a compare between type of ability and monster in typeEffectiveness facts,and return effectiveness
abilityEffectiveness(A,M,E) :- ability(A,TA),monster(M,TM),typeEffectiveness(TA,TM,E).

%this rule tells us which monster's ability against another monster best.
superAbility(M1,A,M2) :- monsterAbility(M1,A),ability(A,TA),monster(M2,T2),typeEffectiveness(TA,T2,super).

%this rule shows that which abilities of a monster share a same type with this monster.
typeAbility(M,A) :- monster(M,TA),monsterAbility(M,A),ability(A,TA).

/*
 * those three queries show which abilities compare to another ability to against a monster is better. 
 * It seems that there is no more effective ability to fight normal type,
 * because there is no ability against normal with weak or super effectiveness.
 * So there should no noraml type in answers.
 */
moreEffectiveAbility(A1,A2,T) :- ability(A1,T1),ability(A2,T2),type(T),typeEffectiveness(T1,T,ordinary),typeEffectiveness(T2,T,weak).
moreEffectiveAbility(A1,A2,T) :- ability(A1,T1),ability(A2,T2),type(T),typeEffectiveness(T1,T,super),typeEffectiveness(T2,T,ordinary).
moreEffectiveAbility(A1,A2,T) :- ability(A1,T1),ability(A2,T2),type(T),typeEffectiveness(T1,T,super),typeEffectiveness(T2,T,weak).

/*
 * those rules mean if a monster M1 use A1 ability will produce less damage than M2 use A2 ability to hit each other, 
 * and I think the same type of monster can't fight themselves (Sorry, I didn't play pokemon before).
 */
counterAbility(M1,A1,M2,A2) :- monsterAbility(M1,A1),monster(M1,TM1),ability(A1,TA1),
                                 monsterAbility(M2,A2),monster(M2,TM2),ability(A2,TA2),
                                 typeEffectiveness(TA1,TM2,weak),typeEffectiveness(TA2,TM1,ordinary),\+M1=M2.
counterAbility(M1,A1,M2,A2) :- monsterAbility(M1,A1),monster(M1,TM1),ability(A1,TA1),
                                 monsterAbility(M2,A2),monster(M2,TM2),ability(A2,TA2),
                                 typeEffectiveness(TA1,TM2,ordinary),typeEffectiveness(TA2,TM1,super),\+M1=M2.
counterAbility(M1,A1,M2,A2) :- monsterAbility(M1,A1),monster(M1,TM1),ability(A1,TA1),
                                 monsterAbility(M2,A2),monster(M2,TM2),ability(A2,TA2),
                                 typeEffectiveness(TA1,TM2,weak),typeEffectiveness(TA2,TM1,super),\+M1=M2.
