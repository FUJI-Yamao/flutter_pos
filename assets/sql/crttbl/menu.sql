drop table if exists c_pos_menu_mst cascade;
CREATE TABLE c_pos_menu_mst (
    comp_cd   numeric(9)
  , stre_cd   numeric(9)
  , menu_grp_cd   numeric(9)
  , menu_object  jsonb
  , ins_datetime TIMESTAMP
  , upd_datetime TIMESTAMP
  , status SMALLINT default 0 not null
  , send_flg SMALLINT default 0 not null
  , upd_user NUMERIC(10) default 0 not null
  , upd_system SMALLINT default 0 not null
  , constraint c_pos_menu_mst_PKC primary key (comp_cd, stre_cd, menu_grp_cd)
) ; 
