
--  ---------- Dataset : world_cup_2015.csv  ,  world_cup_2016.csv -----------------------

# Q.1 Create a view "team_1516" of the players who played in world cup 2015 as well as in world cup 2016.

create view team_1516 as
					 select Player_name 
                     from 	world_cup_2015 
                     where 	Player_Id in ( select Player_Id from world_cup_2016 ) ;
                     

# Q.2 Create a view "All_From_15" that contains all the players who played in world cup 2015 and the players who played in both the world cup matches.

create view All_From_15_vw as
						   select 	 wcl5.Player_Id , wclS5.Player_Name , wclS.runs , popularity , Charisma
						   from 	 world_cup_2015   as wc15
						   left join world_cup_2016   as wc16 
						   on 		 wcl5.Player_Id  =  wcl6.Player_Id ;


# Q.3 Create a view "All_From_16" that contains all the players who played in world cup 2016 and the players who played in both the world cup matches.

create view All_From_16_w as
						  select     wcl6.Player Id , wcl6.Player Name , wcl6.runs , popularity , Charisma
						  from 		 world_cup_2015  as wc15
						  right join world_cup_2016  as wc16
						  on 		 wc15.Player_Id  =  wc16.Player_Id ;


# Q.4 Drop multiple views "all_from_16", "all_from_15", "players_ranked"

drop view   all_from_16_vw , all_from_15_vw , team_1516_vw ;
