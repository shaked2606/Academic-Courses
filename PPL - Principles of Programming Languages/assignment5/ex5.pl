:- module('ex5',
        [activity/2,
         parents/3,
         participate/2,
         parent_details/3,
         not_member/2,
         pick_me_up/2,
         active_child/1,
         activity_participants_list/2,
         can_register/2
        ]).

/*
 * **********************************************
 * Printing result depth
 *
 * You can enlarge it, if needed.
 * **********************************************
 */
maximum_printing_depth(100).

:- current_prolog_flag(toplevel_print_options, A),
   (select(max_depth(_), A, B), ! ; A = B),
   maximum_printing_depth(MPD),
   set_prolog_flag(toplevel_print_options, [max_depth(MPD)|B]).
   
% Signature: activity(Name,Day)/2
% Purpose: describe an activity at the country club and the day it takes place
%
activity(swimming,sunday).
activity(ballet,monday).
activity(judu,tuesday).
activity(soccer,wednesday).
activity(art,sunday).
activity(yoga,tuesday).

% Signature: parents(Child,Parent1,Parent2)/3
% Purpose: parents - child relation
%
parents(dany,hagit,yossi).
parents(dana,hagit,yossi).
parents(guy,meir,dikla).
parents(shai,dor,meni).

% Signature: participate(Child_name,Activity)/2
% Purpose: registration details
%
participate(dany,swimming).
participate(dany,ballet).
participate(dana,soccer).
participate(dana,judu).
participate(guy,judu).
participate(shai,soccer).

% Signature: parent_details(Name,Phone,Has_car)/3
% Purpose: parents details
%
parent_details(hagit,"0545661332",true).
parent_details(yossi,"0545661432",true).
parent_details(meir,"0545661442",false).
parent_details(dikla,"0545441332",true).
parent_details(dor,"0545881332",false).
parent_details(meni,"0545677332",true).

% Signature: not_member(Element, List)/2
% Purpose: The relation in which Element is not a member of a List.
%
not_member(_, []).
not_member(X, [Y|Ys]) :- X \= Y,
                         not_member(X, Ys).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% To Do

% Signature: pick_me_up(Child_name,Phone)/2
% Purpose: The relation between a child name and its parent phone number, when the parent has a car
%
pick_me_up(Child_name,Phone) :- parents(Child_name, P1, P2), parent_details(P1, Phone, true).
pick_me_up(Child_name,Phone) :- parents(Child_name, P1, P2), parent_details(P2, Phone, true).

% Signature: active_child(Name)/1
% Purpose: returns true when a child participates in at least two activities.
%
active_child(Name) :- participate(Name, A1), participate(Name, A2), A1 \= A2.

% Signature: activity_participants_list(Name, List)/2
% Purpose: The relation between activity name and list of all the childrens names that participate at this activity
%
activity_participants_list(Name, List) :- bagof(Child_name, participate(Child_name, Name), List).

% Signature: can_register(Child_name, Activity)/2
% Purpose: The relation between a child name and an activity that the child can register to (the child is available at the day the activity takes place)
%
can_register(Child_name, Activity) :- activity(Activity, Day), bagof(Day_1, is_child_busy_in_day(Child_name, Day_1), List), not_member(Day, List).

% Signature: is_child_busy_in_day(Child_name, Day)/2
% Purpose: The relation between child and day which is busy because he registers to activity
%
is_child_busy_in_day(Child_name, Day) :- activity(Activity, Day), participate(Child_name, Activity).




