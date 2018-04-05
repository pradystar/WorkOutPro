/*
_input_injured(legs).
_expertise(beginner).
_is_available(dumbbell).
_is_available(machine_curls).
_is_available(barbell).
_is_available(lateral_pulley).
_is_available(machine_pulley).
_is_available(machine_preacher_curls).
_is_available(machine_shoulders).
_is_available(bars).
_is_available(machine_flys).
*/

_age_class(A, AC1) :- A < 24, AC1 = young.
_age_class(A, AC1) :- A >= 24, A < 60, AC1 = adult.
_age_class(A, AC1) :- A >= 60, AC1 = old.

% _bmi = (Weight in Pounds / (Height in inches x Height in inches)) x 703
_bmi(H, W, B) :- H2 is H * H, B1 is (W * 703), B is (B1 // H2).	

_health_class(H, W, HCl) :- _bmi(H, W, B), B < 18.5, HCl = underweight.
_health_class(H, W, HCl) :- _bmi(H, W, B), B >= 18.5, B < 25, HCl = normal.
_health_class(H, W, HCl) :- _bmi(H, W, B), B >= 25, HCl = obese.

_calculate_set_information(A, H, W, ECl, WCl, SC, SPE) :- _age_class(A, ACl), _health_class(H, W, HCl), _calculate_set_information(ACl, HCl, ECl, WCl, SC, SPE). 
_calculate_set_information(ACl, HCl, ECl, WCl, SC, SPE) :- _calculate_no_muscles(WCl, MC), 
_calculate_exercises_per_muscles(ACl, EPM), _calculate_sets_per_exercise(ACl, HCl, ECl, SPE), SC is MC * EPM * SPE.

_calculate_no_muscles(circuit, 4).
_calculate_no_muscles(strength2, 2).
_calculate_no_muscles(muscle, 1).

_calculate_exercises_per_muscles(young, 2).
_calculate_exercises_per_muscles(adult, 3).
_calculate_exercises_per_muscles(old, 1).

_calculate_sets_per_exercise(AC1, HCl, EC1, SPE) :- _update_sets_per_exercise(HCl, 0, SC), _update_sets_per_exercise(AC1, SC, SC1), _update_sets_per_exercise(EC1, SC1, SPE).

_update_sets_per_exercise(old, SC, USC) :- SC > 1, USC is SC - 1.
_update_sets_per_exercise(old, SC, USC) :- USC = SC.
_update_sets_per_exercise(adult, SC, USC) :- SC < 3, USC is SC + 1.
_update_sets_per_exercise(adult, SC, USC) :- USC = SC.
_update_sets_per_exercise(young, SC, USC) :- USC = SC.

_update_sets_per_exercise(beginner, SC, USC) :- USC = SC.
_update_sets_per_exercise(intermediate, SC, USC) :- USC = SC.
_update_sets_per_exercise(expert, SC, USC) :- SC < 3, USC is SC + 1.
_update_sets_per_exercise(expert, SC, USC) :- USC = SC.

_update_sets_per_exercise(underweight, _, USC) :- USC = 1.
_update_sets_per_exercise(normal, _, USC) :- USC = 2.
_update_sets_per_exercise(obese, _, USC) :- USC = 2.

/* biceps muscle */
_muscle(biceps_brachi). 
_muscle(brachialis). 
_muscle(brachioradialis). 
 
/* wrist muscle */
_muscle(extensor_carpi_radialis_longus).
_muscle(extensor_carpi_radialis_brevis).
_muscle(extensor_digitorum).
_muscle(extensor_digiti_minimi).
_muscle(extensor_carpi_ulnaris).
_muscle(flexor_carpi_radialis).
_muscle(palmaris_longus).
_muscle(flexor_digitorum).
_muscle(flexor_carpi_ulnaris).
 
/* triceps muscle */
_muscle(triceps_brachii_lat_head).
_muscle(tricpes_brachii_long_head).
_muscle(triceps_brachii_medial_head).
_muscle(anconeus).
 
/* shoulder muscle */
_muscle(anterior_deltoids). 
_muscle(middle_deltoids). 
_muscle(posterior_deltoids). 
 
/* chest muscles */
_muscle(serratus_anterior). 
_muscle(coracobrachialis). 
_muscle(pectoralis_major). 
 
_has(arm, wrist). 
_has(arm, elbow).
_has(shoulder, neck).
 
_injured(P) :- _input_injured(P). 
_injured(biceps_brachi) :- _injured(arm).  
_injured(brachialis) :- _injured(arm). 
_injured(brachioradialis) :- _injured(arm). 
_injured(triceps_brachii_lat_head) :- _injured(arm). 
_injured(tricpes_brachii_long_head) :- _injured(arm). 
_injured(triceps_brachii_medial_head) :- _injured(arm). 
_injured(anconeus) :- _injured(elbow). 
_injured(extensor_carpi_radialis_longus) :- _injured(wrist).
_injured(extensor_carpi_radialis_brevis) :- _injured(wrist).
_injured(extensor_digitorum) :- _injured(wrist).
_injured(extensor_digiti_minimi) :- _injured(wrist).
_injured(extensor_carpi_ulnaris) :- _injured(wrist).
_injured(flexor_carpi_radialis) :- _injured(wrist).
_injured(palmaris_longus) :- _injured(wrist).
_injured(flexor_carpi_radialis) :- _injured(wrist).
_injured(flexor_digitorum) :- _injured(wrist).
_injured(flexor_carpi_ulnaris) :- _injured(wrist).
_injured(anterior_deltoids) :- _injured(shoulder). 
_injured(middle_deltoids) :- _injured(shoulder). 
_injured(posterior_deltoids) :- _injured(shoulder).
_injured(serratus_anterior) :- _injured(chest). 
_injured(pectoralis_major) :- _injured(chest). 
_injured(coracobrachialis) :- _injured(chest).  
_injured(X) :- _has(X, Y), _injured(Y). 
 
/* Uses Muscle */ 
_uses_muscle(Muscle) :- _muscle(Muscle), not _injured(Muscle). 
 
/* Base Curls -  
# Used for biceps 
# Should not be recommended if there is any injury to the arms.  
# This excercise involves biceps, brachialis, bracioradialis  
*/ 
_base_exercise(curls) :- _uses_group(biceps). 
 
/* Base wrist_curl
# Used for wrists
# Should not be recommended if there is any injury to the wrists
# This exercise involves 
*/
_base_exercise(wrist_curls) :- _uses_group(wrist).
 
/* Base triceps
# Used for triceps
# Should not be recommended if there is any injury to the arms, elbow
# This exercise involves 
*/
_base_exercise(triceps) :- _uses_group(triceps).
 
/* Shoulder Press -  
# Used on shoulders  
# Should not be recommended in case of injuries to shoulders and neck 
# Works on deltoids , upper trapezius and triceps, also rhomnoideus and infraspinatus (i.e. the back area)*/ 
_base_exercise(shoulder_press) :- _uses_group(shoulder). 
 
/* Base chest -  
# Used on chest  
# Should not be recommended in case of injuries to chest
*/ 
_base_exercise(chest) :- _uses_group(chest). 
 
/*muscle group used*/
_uses_group(biceps) :- 
    _uses_muscle(biceps_brachi), _uses_muscle(brachialis), _uses_muscle(brachioradialis). 
 
_uses_group(shoulder) :- 
    _uses_muscle(anterior_deltoids), _uses_muscle(middle_deltoids), _uses_muscle(posterior_deltoids).
 
_uses_group(wrist) :- 
    _uses_muscle(extensor_carpi_radialis_longus), _uses_muscle(extensor_carpi_radialis_brevis),         _uses_muscle(extensor_digitorum), _uses_muscle(extensor_digiti_minimi),
    _uses_muscle(extensor_carpi_ulnaris), _uses_muscle(flexor_carpi_radialis), 
    _uses_muscle(palmaris_longus), _uses_muscle(flexor_digitorum), _uses_muscle(flexor_carpi_ulnaris).
 
_uses_group(triceps) :-
    _uses_muscle(triceps_brachii_lat_head), _uses_muscle(tricpes_brachii_long_head), 
    _uses_muscle(triceps_brachii_medial_head), _uses_muscle(anconeus).
 
_uses_group(chest) :-
    _uses_muscle(serratus_anterior), _uses_muscle(pectoralis_major), _uses_muscle(coracobrachialis).
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% biceps curls %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
/* Dumbbell Curls */ 
_exercise(curls) :- 
    not _expertise(beginner), _is_available(dumbbell), _base_exercise(curls). 
 
/* Concentration Curls*/
_exercise(concentration_curls) :- 
    not _expertise(beginner), _is_available(dumbbell), _base_exercise(curls).
 
/* Hammer curls */
_exercise(hammer_curls) :- 
    not _expertise(beginner), _is_available(dumbbell), _base_exercise(curls).
 
/* Low pulley curls */
_exercise(low_pulley_curls) :- 
    _is_available(machine_pulley), _base_exercise(curls).
 
/* High pulley curls */
_exercise(high_pulley_curls) :- 
    _is_available(machine_pulley), _base_exercise(curls).
 
/* Barbell curls */ 
_exercise(barbell_curls) :- 
    not _expertise(beginner), _is_available(barbell), _base_exercise(curls). 
 
/* Machine Curls */ 
_exercise(machine_curls) :- 
    _is_available(machine_curls), _base_exercise(curls). 
 
/* Preacher Curls */
_exercise(preacher_curls) :- 
    not _expertise(beginner), not _expertise(intermediate), _is_available(machine_preacher_curls),         _base_exercise(curls).
 
/* Reverse Curls - should be done along with bench press??*/
_exercise(reverse_curls) :- 
    not _expertise(beginner), _is_available(barbell), _base_exercise(curls).
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% wrist curls %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
/* wrist curls */
_exercise(wrist_curls) :- 
    not _expertise(beginner), _is_available(barbell), _base_exercise(wrist_curls).
 
/* Reverse wrist curls */
_exercise(reverse_wrist_curls) :- 
    not _expertise(beginner), _is_available(barbell), _base_exercise(wrist_curls).
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% triceps %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
/* pushdowns */
_exercise(pushdowns) :- 
    _is_available(machine_pulley), _base_exercise(triceps).
 
/* reverse pushdowns */
_exercise(reverse_pushdown) :-
    _is_available(machine_pulley), _base_exercise(triceps).
 
/* triceps extension -- barbell or dumbbell */
_exercise(barbell_triceps_extension) :- 
    not _expertise(beginner), _is_available(barbell), _base_exercise(triceps).
 
_exercise(dumbbell_triceps_extension) :- 
    not _expertise(beginner), _is_available(dumbbell), _base_exercise(triceps).
 
/* tirceps kickbacks (allowed for beginners)*/
_exercise(triceps_kickback) :- 
    _is_available(dumbbell), _base_exercise(triceps).
 
/* triceps dips */
_exercise(triceps_dips) :- 
    _base_exercise(triceps).
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% shoulder %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
/* Back press */ 
_exercise(back_press) :- 
    not _expertise(beginner), not _injured(neck), _is_available(barbell), 
    _base_exercise(shoulder_press). 
 
/* Front press */
_exercise(front_press) :-
    not _expertise(beginner), _is_available(barbell), _base_exercise(triceps),
    _base_exercise(shoulder_press). 
 
/* Dumbbell press (beginners allowed) */
_exercise(dumbbell_press) :-
    _is_available(dumbbell), _base_exercise(shoulder_press).
 
/* Lateral Raises */
_exercise(lateral_raises) :-
    not _expertise(beginner), _is_available(dumbbell), _base_exercise(shoulder_press).
 
/* Bent Over Lateral Raises */
_exercise(bent_over_lateral_raises) :-
    not _expertise(beginner), not _expertise(intermediate), _is_available(dumbbell),
    _base_exercise(shoulder_press).  

/* Front Raises */
_exercise(dumbbell_front_raises) :- 
    not _expertise(beginner), _is_available(dumbbell), _base_exercise(shoulder_press).
	
_exercise(barbell_front_raises) :- 
    not _expertise(beginner), _is_available(barbell), _base_exercise(shoulder_press).
 
/* Upright rows */
_exercise(upright_rows) :-
    not _expertise(beginner), not _expertise(intermediate), _is_available(barbell),
    _base_exercise(shoulder_press).
 
/* Low pulley Lateral Raises (beginners allowed) */
_exercise(low_pulley_lateral_raises) :-
    _is_available(machine_pulley), _base_exercise(shoulder_press).
 
/* Low pulley Bent Over Lateral Raises */
_exercise(low_pulley_bent_over_lateral_raises) :-
    not _expertise(beginner), _is_available(machine_pulley),
    _base_exercise(shoulder_press).
	
/* Low pulley Front Raises */
_exercise(low_pulley_front_raises) :- 
    _is_available(machine_pulley), _base_exercise(shoulder_press).    
 
/* Nautilus_lateral_riases */
_exercise(nautilus_lateral_raises) :- 
    _is_available(machine_shoulders), _base_exercise(shoulder_press).    
 
/* Pec Deck Rear Delt Laterals */
_exercise(pec_deck_rear_delt_laterals) :-
    not _expertise(beginner), _is_available(machine_shoulders), _base_exercise(shoulder_press).
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% chest %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
/* Bench Press */
_exercise(dumbbell_bench_press) :-
    not _expertise(beginner),_is_available(dumbbell), 
    _base_exercise(shoulder_press), _base_exercise(triceps), _base_exercise(chest).
 
_exercise(dumbbell_incline_press) :-
    not _expertise(beginner),_is_available(dumbbell), 
    _base_exercise(shoulder_press), _base_exercise(triceps), _base_exercise(chest).

_exercise(barbell_bench_press) :-
    not _expertise(beginner), _is_available(barbell), 
    _base_exercise(shoulder_press), _base_exercise(triceps), _base_exercise(chest).
 
_exercise(barbell_incline_press) :-
    not _expertise(beginner), _is_available(barbell), 
    _base_exercise(shoulder_press), _base_exercise(triceps), _base_exercise(chest).
 
_exercise(barbell_decline_press) :-
    not _expertise(beginner), _is_available(barbell), 
    _base_exercise(shoulder_press), _base_exercise(triceps), _base_exercise(chest).
 
_exercise(push_ups) :- 
    _base_exercise(shoulder_press), _base_exercise(triceps), _base_exercise(chest).
 
_exercise(parellel_bar_dips) :-
    not _expertise(beginner), _is_available(bars), _base_exercise(shoulder_press), 
    _base_exercise(triceps), _base_exercise(chest).
 
_exercise(flys) :-
    not _expertise(beginner), _is_available(dumbbell), _base_exercise(chest).
 
_exercise(machine_flys) :-
    _is_available(machine_flys), _base_exercise(chest).
 
_exercise(cable_flys) :-
    not _expertise(beginner), not _expertise(intermediate), _is_available(machine_pulley), 
    _base_exercise(chest).
 
_exercise(dumbbell_pullovers) :-
    _is_available(dumbbell), _base_exercise(triceps),
    _base_exercise(chest).
	
_exercise(barbell_pullovers) :-
    _is_available(barbell), _base_exercise(triceps),
    _base_exercise(chest).
 
 
/*Dumbbell press - for strength training - works on shoulders (deltoideus), should not be recommended if there is any injury to the shoulders, requires dumbbells in each hand, works on dltoids, upper trapezius ( both mean shoulder area) and tricpes 
 
_exercise(dumbbell_press) :- 
 
low pulley lateral raises - for strength training - works on the shoulders (deltoideus), should not be recommended in case of injury to the shoulder, requires machine, this focuses on the deltoids (shoulders) 
 
bench press - for strength training - works on chest and triceps(secondary), should not be recommended in case of injury to chest and triceps, uses barbell, focuses on pectorals(chest), and also tricpes, deltoids(shoulders), serratus(side body :) ) and coracobrachialis(chest) 
 
incline press - for strenght training - works on chest and tricpes, should not be recommened in case of injury to chest and triceps, uses barbell, works on upper pecorals(chest) dletoids(shoulders) and triceps 
 
push ups - for strength training - chest and triceps, free hands - no weights, no machine, can be used for warmup, focuces  te pectoalis(chest) and triceps(brachii). 
 
dumbbell press - variation of bench press with dumbbells 
 
chin ups - for strength training - full back - no weights, uses mounted bar, should not be recommended in case of injury to the back. Focuses on full back and also biceps and pectoralis(chest) 
 
lat pulldowns - for strength training - full back - machine , not recommended in case of back and biceps injury, focuses on back and biceps also to some extent pectorals. 
 
stiff-legged deadlifts - for strenght training - lower back - barbell - should not be recommened in case of back injuries problems focuses on the lower back and thighs. 
 
NOTE: almost all back exercises should not be recommended immediately after bicpes intensive training,same for excercise like deadlifts and back extension, they involve the leg muscles  
 
upright rows - for strength training - upper back - barbell - should not be recommended in case of back injury - focuses on the trapezius(upper back) and also deltoids, biceps, forearms, abdominals, buttocks 
 
squats - for strength training - legs(thights and buttocks) - can be done with dumbells or barbells, should not be recommended in case of leg injuries. works on quadriceps, gluteals, adductors, abdominals, hamstrings 
 
angled leg press - for strength training - legs(thighs and buttocks) - requires machine, should not be recommended in case of back injury, works on quadriceps. 
 
lying leg curls - for strength trainign - legs(claf and ankels) - machine, should not be recommended in case of back injury 
 
*/

_member(X, [X|_]).
_member(X, [_|L]) :- _member(X,L).

_select(X, [X|T], T). 
_select(X, [_|T], T1) :- _select(X, T, T1). 
 
_append([],L,L). 
_append([X|A],B,[X|C]) :- _append(A,B,C). 
 
_exercises(biceps, EL) :- 
    EL = [preacher_curls, curls, concentration_curls, hammer_curls, barbell_curls, reverse_curls,         machine_curls, low_pulley_curls, high_pulley_curls]. 
_exercises(wrist, EL) :-
    EL = [wrist_curls, reverse_wrist_curls].
_exercises(triceps, EL) :-
    EL = [dumbbell_triceps_extension, barbell_triceps_extension, pushdowns, reverse_pushdowns, triceps_kickback, triceps_dips].
_exercises(shoulder, EL) :- 
    EL = [bent_over_lateral_raises, upright_rows, back_press, front_press, lateral_raises, 
    dumbbell_front_raises, barbell_front_raises, low_pulley_bent_over_lateral_raises, pec_deck_rear_delt_laterals, dumbbell_press,     low_pulley_lateral_raises, low_pulley_front_raises, nautilus_lateral_raises]. 
_exercises(chest, EL) :-
    EL = [dumbbell_bench_press, dumbbell_incline_press, barbell_bench_press, barbell_incline_press, barbell_decline_press,	parallel_bar_dips, flys, cable_flys, push_ups, dumbbell_pullovers, barbell_pullovers, machine_flys].

_filterList([], _, []).
_filterList(L, [], L).
_filterList([H|T], FL, [H|OL]) :- not _member(H, FL), _filterList(T, FL, OL).
_filterList([H|T], FL, OL) :- _member(H, FL), _filterList(T, FL, OL).

_select_major_muscles(N, SM, ML) :- 
    _filterList([chest, biceps, triceps, shoulder], SM, FL), _select_major_muscles_combinations(N, FL, ML). 
 
_select_major_muscles_combinations(0, _, []). 
_select_major_muscles_combinations(N, M, [L|SM]) :- 
    _select(L, M, M1), N > 0, N1 is N - 1, _select_major_muscles_combinations(N1, M1, SM). 

_get_muscles([], []).
_get_muscles([_muscle_exercises(M, _)|T], [M|SM]) :- _get_muscles(T, SM).

_get_exercises([], []).
_get_exercises([_muscle_exercises(_, L)|T], TE) :- _get_exercises(T, SE), _append(L, SE, TE).

% SC max set count
% N is number of major muscles
% SPE is sets per exercise
% EC is exercise count
_make_day_plan(N, EC, SMs, SEs, EL) :- _get_muscles(SMs, SM), _get_exercises(SEs, SE), _select_major_muscles(N, SM, ML), _select_exercises(ML, EC, SE, EL). 
 
_select_exercises([], _, _, []). 
_select_exercises([M|L], N, FE, [MEs|ML]) :- 
    _select_major_muscle_exercises(M, N, FE, MEs), _select_exercises(L, N, FE, ML).
 
_select_major_muscle_exercises(M, N, FE, _muscle_exercises(M, MEL)) :- 
    _exercises(M, EL), _filterList(EL, FE, RE), _select_major_muscle_exercise(N, RE, MEL).
_select_major_muscle_exercises(M, N, _, _muscle_exercises(M, MEL)) :- 
    _exercises(M, EL), _select_major_muscle_exercise(N, EL, MEL).
	
_select_major_muscle_exercise(0, _, []). 
_select_major_muscle_exercise(N, M, [L|SM]) :- 
    _select(L, M, M1), _exercise(L), N > 0, N1 is N - 1, _select_major_muscle_exercise(N1, M1, SM). 
 
_write_exercises([], _). 
_write_exercises([H|T], SPE) :- write(H), write(' '), write(SPE), write(' sets of 10 reps'), write('|'),nl, _write_exercises(T, SPE).

_strength_training_2_days(SC, SPE) :-  SPM is 2 * SPE, EC is SC / SPM, 
_make_day_plan(2, EC, [], [], EL1), 
_make_day_plan(2, EC, EL1, [], EL2),
_writePlan([EL1,EL2], 2, 1, SPE).

_strength_training_2_days(SC, SPE, unbounded) :-  SPM is 2 * SPE, EC is SC / SPM, 
_make_day_plan(2, EC, [], [], EL1), 
_make_day_plan(2, EC, EL1, [], EL2), _append(EL1, EL2, EL12), 
_make_day_plan(2, EC, [], EL12, EL3), _append(EL12, EL3, EL13), 
_make_day_plan(2, EC, EL3, EL13, EL4), _append(EL13, EL4, EL14),
_make_day_plan(2, EC, [], EL14, EL5), _append(EL14, EL5, EL15),
_make_day_plan(2, EC, EL5, EL15, EL6), 
_writePlan([EL1,EL2,EL3,EL4,EL5,EL6], 6, 1, SPE).

_muscle_building_training_4_days(SC, SPE) :-  SPM is 1 * SPE, EC is SC / SPM, 
_make_day_plan(1, EC, [], [], EL1), 
_make_day_plan(1, EC, EL1, [], EL2), _append(EL1, EL2, EL12), 
_make_day_plan(1, EC, EL12, [], EL3), _append(EL12, EL3, EL13), 
_make_day_plan(1, EC, EL13, [], EL4),
_writePlan([EL1,EL2,EL3,EL4], 4, 1, SPE).

_muscle_building_training_4_days(SC, SPE, unbounded) :-  SPM is 1 * SPE, EC is SC / SPM, 
_make_day_plan(1, EC, [], [], EL1), 
_make_day_plan(1, EC, EL1, [], EL2), _append(EL1, EL2, EL12), 
_make_day_plan(1, EC, EL12, [], EL3), _append(EL12, EL3, EL13),
_make_day_plan(1, EC, EL13, [], EL4), _append(EL13, EL4, EL14),
_make_day_plan(1, EC, [], EL14, EL5), _append(EL14, EL5, EL15),
_make_day_plan(1, EC, EL5, EL15, EL6),
_writePlan([EL1,EL2,EL3,EL4,EL5,EL6], 6, 1, SPE).

_circuit_training_1_day(SC, SPE) :-  SPM is 4 * SPE, EC is SC / SPM, 
_make_day_plan(4, EC, [], [], EL1),
_writePlan([EL1], 1, 1, SPE).

_circuit_training_1_day(SC, SPE, unbounded) :-  SPM is 4 * SPE, EC is SC / SPM, 
_make_day_plan(4, EC, [], [], EL1), 
_make_day_plan(4, EC, [], EL1, EL2), _append(EL1, EL2, EL12), 
_make_day_plan(4, EC, [], EL12, EL3), _append(EL12, EL3, EL13), 
_make_day_plan(4, EC, [], EL13, EL4), _append(EL13, EL4, EL14),
_make_day_plan(4, EC, [], EL14, EL5), _append(EL14, EL5, EL15),
_make_day_plan(4, EC, [], EL15, EL6), 
_writePlan([EL1,EL2,EL3,EL4,EL5,EL6], 6, 1, SPE).

_writePlan([], _, _, _).
_writePlan([H|T], N, C, SPE) :- C =< N, write('Day '), write(C), nl,write('|'), nl, _writePlan(H, SPE), C1 is C+1, _writePlan(T, N, C1, SPE).

_writePlan([], _).
_writePlan([_muscle_exercises(M, EL)|T], SPE) :- write(M),write('|'), nl, _write_exercises(EL, SPE), nl, _writePlan(T, SPE).

_plan_workout(A, H, W, ECl, circuit) :- _calculate_set_information(A, H, W, ECl, circuit, SC, SPE), _circuit_training_1_day(SC, SPE).

_plan_workout(A, H, W, ECl, strength2) :- _calculate_set_information(A, H, W, ECl, strength2, SC, SPE), _strength_training_2_days(SC, SPE).

_plan_workout(A, H, W, ECl, muscle) :- _calculate_set_information(A, H, W, ECl, muscle, SC, SPE), _muscle_building_training_4_days(SC, SPE).

_plan_workout(A, H, W, ECl, circuit, unbounded) :- _calculate_set_information(A, H, W, ECl, circuit, SC, SPE), _circuit_training_1_day(SC, SPE, unbounded).

_plan_workout(A, H, W, ECl, strength2, unbounded) :- _calculate_set_information(A, H, W, ECl, strength2, SC, SPE), _strength_training_2_days(SC, SPE, unbounded).

_plan_workout(A, H, W, ECl, muscle, unbounded) :- _calculate_set_information(A, H, W, ECl, muscle, SC, SPE), _muscle_building_training_4_days(SC, SPE, unbounded).

%#compute 1{_plan_workout(20, 70, 154, beginner, strength2)}.
