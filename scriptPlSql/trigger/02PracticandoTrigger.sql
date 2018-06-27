/**
    @author Adrian;;
    @since 06-06-2018;;
    TODO practicando los trigger de oracle;;
*/

create table games (
    idgm varchar2(50) not null primary key,
    title varchar2(50) not null,
    descriptionGame varchar2(100)  not null
);


create table log_games (
    idLogGame varchar2(50) not null primary key,
    dateLogGame date not null,
    typeLogGame varchar2(50) not null,
    titleLogGame varchar2(50) not null
);

-- Triger

create or replace trigger insert_log_game
    after insert on games
    for each row
    declare
        vDate date;
    begin
        select sysdate into vDate from dual;
        insert into log_games (idLogGame, dateLogGame, typeLogGame, titleLogGame)
        values ('I-' || :new.idgm, vDate, 'insert', :new.title);
    end;
    
-- insert
insert into games (idgm, title, descriptionGame)
values ('SKR01', 'Skirim 5', 'The elder scroll saga');