PLUGIN.name = "Promotion System"
PLUGIN.author = "RobertLP"
PLUGIN.desc = "Easily promote people using lua tables"

local rankfaction = FACTION_CITIZEN
local neutralfaction = FACTION_CITIZEN

ranks = {
  heer = {
    {name = "Grenadier", model  = "models/kriegsyntax/germans/wehrmacht/enlisted/schutze/playermodel.mdl"},
    {name = "Obergrenadier", model  = "models/kriegsyntax/germans/wehrmacht/enlisted/oberschutze/playermodel.mdl"},
    {name = "Gefreiter", model  = "models/kriegsyntax/germans/wehrmacht/enlisted/gefreiter/playermodel.mdl"},
    {name = "Obergefreiter", model  = "models/kriegsyntax/germans/wehrmacht/enlisted/obergefreiter/playermodel.mdl"},
    {name = "Stabsgefreiter", model  = "models/kriegsyntax/germans/wehrmacht/enlisted/stabsgefreiter/playermodel.mdl"},

    {name = "Unteroffizier", model  = "models/kriegsyntax/germans/wehrmacht/ncos/unteroffizer/playermodel_2.mdl"},
    {name = "Unterfeldwebel", model  = "models/kriegsyntax/germans/wehrmacht/ncos/unterfeldwebel/playermodel_2.mdl"},
    {name = "Feldwebel", model  = "models/kriegsyntax/germans/wehrmacht/ncos/feldwebel/playermodel_2.mdl"},
    {name = "Oberfeldwebel", model  = "models/kriegsyntax/germans/wehrmacht/ncos/oberfeldwebel/playermodel_2.mdl"},
    {name = "Stabsfeldwebel", model  = "models/kriegsyntax/germans/wehrmacht/ncos/stabsfeldwebel/playermodel_2.mdl"},

    {name = "Leutnant", model  = "models/kriegsyntax/germans/wehrmacht/cos/leutnant/playermodel_2.mdl"},
    {name = "Oberleutnant", model  = "models/kriegsyntax/germans/wehrmacht/cos/oberleutnant/playermodel_2.mdl"},
    {name = "Hauptmann", model  = "models/kriegsyntax/germans/wehrmacht/cos/hauptmann/playermodel_2.mdl"},
    {name = "Major", model  = "models/kriegsyntax/germans/wehrmacht/cos/major/playermodel.mdl"},
    {name = "Oberstleutnant", model  = "models/kriegsyntax/germans/wehrmacht/cos/oberstleutnant/playermodel.mdl"},
    {name = "Oberst", model  = "models/kriegsyntax/germans/wehrmacht/cos/oberst/playermodel.mdl"}
  },
  feld = {
    {name = "Feldgendarm", model  = "models/kriegsyntax/germans/wehrmacht/enlisted/feldgendarmerie/playermodel.mdl"},
    {name = "Feldobergendarm", model  = "models/kriegsyntax/germans/wehrmacht/enlisted/oberschutze/playermodel.mdl"},
    {name = "Gefreiter der Feldgendarmerie", model  = "models/kriegsyntax/germans/wehrmacht/enlisted/gefreiter/playermodel.mdl"},
    {name = "Obergefreiter der Feldgendarmerie", model  = "models/kriegsyntax/germans/wehrmacht/enlisted/obergefreiter/playermodel.mdl"},
    {name = "Stabsgefreiter der Feldgendarmerie", model  = "models/kriegsyntax/germans/wehrmacht/enlisted/stabsgefreiter/playermodel.mdl"},

    {name = "Unteroffizier der Feldgendarmerie", model  = "models/kriegsyntax/germans/wehrmacht/enlisted/feldgendarmerie/playermodel_2.mdl"},
    {name = "Unterfeldwebel der Feldgendarmerie", model  = "models/kriegsyntax/germans/wehrmacht/ncos/unterfeldwebel/playermodel_2.mdl"},
    {name = "Feldwebel der Feldgendarmerie", model  = "models/kriegsyntax/germans/wehrmacht/ncos/feldwebel/playermodel_2.mdl"},
    {name = "Oberfeldwebel der Feldgendarmerie", model  = "models/kriegsyntax/germans/wehrmacht/ncos/oberfeldwebel/playermodel_2.mdl"},
    {name = "Stabsfeldwebel der Feldgendarmerie", model  = "models/kriegsyntax/germans/wehrmacht/winter/ncos/stabsfeldwebel/playermodel_2.mdl"},

    {name = "Leutnant der Feldgendarmerie", model  = "models/kriegsyntax/germans/wehrmacht/cos/leutnant/playermodel.mdl"},
    {name = "Oberleutnant der Feldgendarmerie", model  = "models/kriegsyntax/germans/wehrmacht/cos/oberleutnant/playermodel.mdl"},
    {name = "Hauptmann der Feldgendarmerie", model  = "models/kriegsyntax/germans/wehrmacht/cos/hauptmann/playermodel.mdl"},
  },
  gross = {
    {name = "Grenadier", model = "models/kriegsyntax/germans/wehrmacht/grossdeutschland/enlisted/schutze/playermodel.mdl"},
    {name = "Obergrenadier", model = "models/kriegsyntax/germans/wehrmacht/grossdeutschland/enlisted/oberschutze/playermodel.mdl"},
    {name = "Gefreiter", model = "models/kriegsyntax/germans/wehrmacht/grossdeutschland/enlisted/gefreiter/playermodel.mdl"},
    {name = "Obergefreiter", model = "models/kriegsyntax/germans/wehrmacht/grossdeutschland/enlisted/obergefreiter/playermodel.mdl"},
    {name = "Stabsgefreiter", model = "models/kriegsyntax/germans/wehrmacht/grossdeutschland/enlisted/stabsgefreiter/playermodel.mdl"},

    {name = "Unteroffizier", model = "models/kriegsyntax/germans/wehrmacht/grossdeutschland/ncos/unteroffizer/playermodel_2.mdl"},
    {name = "Unterfeldwebel", model = "models/kriegsyntax/germans/wehrmacht/grossdeutschland/ncos/unterfeldwebel/playermodel_2.mdl"},
    {name = "Feldwebel", model = "models/kriegsyntax/germans/wehrmacht/grossdeutschland/ncos/feldwebel/playermodel_2.mdl"},
    {name = "Oberfeldwebel", model = "models/kriegsyntax/germans/wehrmacht/grossdeutschland/ncos/oberfeldwebel/playermodel_2.mdl"},
    {name = "Stabsfeldwebel", model = "models/kriegsyntax/germans/wehrmacht/grossdeutschland/ncos/stabsfeldwebel/playermodel_2.mdl"},

    {name = "Leutnant", model = "models/kriegsyntax/germans/wehrmacht/grossdeutschland/cos/leutnant/playermodel.mdl"},
    {name = "Oberleutnant", model = "models/kriegsyntax/germans/wehrmacht/grossdeutschland/cos/oberleutnant/playermodel.mdl"},
    {name = "Hauptmann", model = "models/kriegsyntax/germans/wehrmacht/grossdeutschland/cos/hauptmann/playermodel.mdl"},
    {name = "Major", model = "models/kriegsyntax/germans/wehrmacht/grossdeutschland/cos/major/playermodel.mdl"},
    {name = "Oberstleutnant", model = "models/kriegsyntax/germans/wehrmacht/grossdeutschland/cos/oberstleutnant/playermodel.mdl"},
    {name = "Oberst", model = "models/kriegsyntax/germans/wehrmacht/grossdeutschland/cos/oberst/playermodel.mdl"},
	{name = "Generalmajor", model = "models/kriegsyntax/germans/wehrmacht/grossdeutschland/cos/generalmajor/playermodel.mdl"},
	{name = "Generalleutnant", model = "models/kriegsyntax/germans/wehrmacht/grossdeutschland/cos/generalleutnant/playermodel.mdl"},
	{name = "General Der Infantarie", model = "models/kriegsyntax/germans/wehrmacht/grossdeutschland/cos/generalderinfantrie/playermodel.mdl"},
	{name = "Generaloberst", model = "models/kriegsyntax/germans/wehrmacht/grossdeutschland/cos/generaloberst/playermodel.mdl"},
  },
  nsdap = {
    {name = "Helfer", model = "models/kriegsyntax/germans/nsdap/lowcommand/helfer/playermodel.mdl"},
    {name = "Oberhelfer", model = "models/kriegsyntax/germans/nsdap/lowcommand/oberhelfer/playermodel.mdl"},
    {name = "Arbeitsleiter", model = "models/kriegsyntax/germans/nsdap/lowcommand/arbeitsleiter/playermodel.mdl"},
    {name = "Oberarbeitsleiter", model = "models/kriegsyntax/germans/nsdap/lowcommand/oberarbeitsleiter/playermodel.mdl"},
    {name = "Hauptarbeitsleiter", model = "models/kriegsyntax/germans/nsdap/lowcommand/hauptarbeitsleiter/playermodel.mdl"},
    {name = "Bereitschaftsleiter", model = "models/kriegsyntax/germans/nsdap/lowcommand/bereitschaftsleiter/playermodel.mdl"},
    {name = "Oberbereitschaftsleiter", model = "models/kriegsyntax/germans/nsdap/lowcommand/oberbereitschaftsleiter/playermodel.mdl"},
    {name = "Hauptbereitschaftsleiter", model = "models/kriegsyntax/germans/nsdap/lowcommand/hauptbereitschaftsleiter/playermodel.mdl"},
    {name = "Einsatzleiter", model = "models/kriegsyntax/germans/nsdap/lowcommand/einsatzleiter/playermodel.mdl"},
    {name = "Obereinzatsleiter", model = "models/kriegsyntax/germans/nsdap/lowcommand/obereinsatzleiter/playermodel.mdl"},
    {name = "Haupteinsatzleiter", model = "models/kriegsyntax/germans/nsdap/lowcommand/haupteinsatzleiter/playermodel.mdl"},
    {name = "Gemeinschaftsleiter", model = "models/kriegsyntax/germans/nsdap/lowcommand/gemeinschaftsleiter/playermodel.mdl"},
    {name = "Obergemeinschaftsleiter", model = "models/kriegsyntax/germans/nsdap/lowcommand/obergemeinschaftsleiter/playermodel.mdl"},
    {name = "Hauptgemeinschaftsleiter", model = "models/kriegsyntax/germans/nsdap/lowcommand/hauptgemeinschaftsleiter/playermodel.mdl"},
    {name = "Abscnhittsleiter", model = "models/kriegsyntax/germans/nsdap/highcommand/abschnittsleiter/playermodel.mdl"},
	{name = "Oberabschnittsleiter", model = "models/kriegsyntax/germans/nsdap/highcommand/oberabschnittsleiter/playermodel.mdl"},
    {name = "Hauptabschnittsleiter", model = "models/kriegsyntax/germans/nsdap/highcommand/hauptabschnittsleiter/playermodel.mdl"},
    {name = "Bereichsleiter", model = "models/kriegsyntax/germans/nsdap/highcommand/bereichsleiter/playermodel.mdl"},
    {name = "Hauptbereichsleiter", model = "models/kriegsyntax/germans/nsdap/highcommand/hauptbereichsleiter/playermodel.mdl"},
    {name = "Dienstleiter", model = "models/kriegsyntax/germans/nsdap/highcommand/dienstleiter/playermodel.mdl"},
    {name = "Oberdienstleiter", model = "models/kriegsyntax/germans/nsdap/highcommand/oberdienstleiter/playermodel.mdl"},
    {name = "Hauptdienstleiter", model = "models/kriegsyntax/germans/nsdap/highcommand/hauptdienstleiter/playermodel.mdl"},
    {name = "Befehlsleiter", model = "models/kriegsyntax/germans/nsdap/highcommand/befehlsleiter/playermodel.mdl"},
    {name = "Oberbefehlsleiter", model = "models/kriegsyntax/germans/nsdap/highcommand/oberbefehlsleiter/playermodel.mdl"},
    {name = "Hauptbefehlsleiter", model = "models/kriegsyntax/germans/nsdap/highcommand/hauptbefehlsleiter/playermodel.mdl"},
    {name = "Reichsleiter", model = "models/kriegsyntax/germans/nsdap/highcommand/reichsleiter/playermodel.mdl"},
  },
  sd = {
    {name = "SiPo Mann", model = "models/kriegsyntax/germans/waffenss/enlisted/schutze/playermodel.mdl"},
    {name = "SiPo Sturmann", model = "models/kriegsyntax/germans/waffenss/enlisted/sturmmann/playermodel.mdl"},
    {name = "SiPo Rottenführer", model = "models/kriegsyntax/germans/waffenss/enlisted/rottenfuhrer/playermodel.mdl"},
	
	{name = "Unterscharführer", model = "models/kriegsyntax/germans/ss/sd/ncos/unterscharfuhrer/playermodel.mdl"},
    {name = "Scharführer", model = "models/kriegsyntax/germans/ss/sd/ncos/scharfuhrer/playermodel.mdl"},
    {name = "Oberscharführer", model = "models/kriegsyntax/germans/ss/sd/ncos/oberscharfuhrer/playermodel.mdl"},
    {name = "Hauptscharführer", model = "models/kriegsyntax/germans/ss/sd/ncos/hauptscharfuhrer/playermodel.mdl"},
    {name = "Sturmscharführer", model = "models/kriegsyntax/germans/ss/sd/ncos/stabsfeldwebel/playermodel.mdl"},

    {name = "Untersturmführer", model = "models/kriegsyntax/germans/ss/sd/cos/untersturmfuhrer/playermodel.mdl"},
    {name = "Obersturmführer", model = "models/kriegsyntax/germans/ss/sd/cos/obersturmfuhrer/playermodel.mdl"},
    {name = "Hauptsturmführer", model = "models/kriegsyntax/germans/ss/sd/cos/hauptsturmfuhrer/playermodel.mdl"},
    {name = "Sturmbannführer", model = "models/kriegsyntax/germans/ss/sd/cos/sturmbannfuhrer/playermodel.mdl"},
	{name = "Obersturmbannführer", model = "models/kriegsyntax/germans/ss/sd/cos/obersturmbannfuhrer/playermodel.mdl"},
    {name = "Standartenführer", model = "models/kriegsyntax/germans/ss/sd/cos/standartenfuhrer/playermodel.mdl"},
	{name = "Oberführer", model = "models/kriegsyntax/germans/ss/sd/cos/oberfuhrer/playermodel.mdl"},
  },
  korps = {
    {name = "schütze", model = "models/kriegsyntax/germans/wehrmacht/panzer/enlisted/schutze/playermodel.mdl"},
    {name = "Oberschütze", model = "models/kriegsyntax/germans/wehrmacht/panzer/enlisted/oberschutze/playermodel.mdl"},
    {name = "Pz Gefreiter", model  = "models/kriegsyntax/germans/wehrmacht/panzer/enlisted/gefreiter/playermodel.mdl"},
    {name = "Pz Obergefreiter", model  = "models/kriegsyntax/germans/wehrmacht/panzer/enlisted/stabsgefreiter/playermodel.mdl"},

    {name = "Pz Unteroffizier", model  = "models/kriegsyntax/germans/wehrmacht/panzer/ncos/unteroffizer/playermodel.mdl"},
    {name = "Pz Unterfeldwebel", model  = "models/kriegsyntax/germans/wehrmacht/panzer/ncos/unterfeldwebel/playermodel_2.mdl"},
    {name = "Pz Feldwebel", model  = "models/kriegsyntax/germans/wehrmacht/panzer/ncos/feldwebel/playermodel_2.mdl"},
    {name = "Pz Oberfeldwebel", model  = "models/kriegsyntax/germans/wehrmacht/panzer/ncos/oberfeldwebel/playermodel_2.mdl"},
    {name = "Pz Stabsfeldwebel", model  = "models/kriegsyntax/germans/wehrmacht/panzer/ncos/stabsfeldwebel/playermodel_2.mdl"},

    {name = "Pz Leutnant", model  = "models/kriegsyntax/germans/wehrmacht/panzer/cos/leutnant/playermodel.mdl"},
    {name = "Pz Oberleutnant", model  = "models/kriegsyntax/germans/wehrmacht/panzer/cos/oberleutnant/playermodel.mdl"},
    {name = "Pz Hauptmann", model  = "models/kriegsyntax/germans/wehrmacht/panzer/cos/hauptmann/playermodel.mdl"},
  },
  ss = {
    {name = "Mann", model = "models/kriegsyntax/germans/ss/enlisted/schutze/playermodel.mdl"},
    {name = "Sturmmann", model = "models/kriegsyntax/germans/ss/enlisted/sturmmann/playermodel.mdl"},
    {name = "Rottenführer", model = "models/kriegsyntax/germans/ss/enlisted/rottenfuhrer/playermodel.mdl"},

    {name = "Unterscharführer", model = "models/kriegsyntax/germans/ss/ncos/unterscharfuhrer/playermodel_2.mdl"},
    {name = "Scharführer", model = "models/kriegsyntax/germans/ss/ncos/scharfuhrer/playermodel_2.mdl"},
    {name = "Oberscharführer", model = "models/kriegsyntax/germans/ss/ncos/oberscharfuhrer/playermodel_2.mdl"},
    {name = "Hauptscharführer", model = "models/kriegsyntax/germans/ss/ncos/hauptscharfuhrer/playermodel_2.mdl"},
    {name = "Sturmscharführer", model = "models/kriegsyntax/germans/ss/ncos/stabsscharfuhrer/playermodel_2.mdl"},

    {name = "Untersturmführer", model = "models/kriegsyntax/germans/ss/cos/untersturmfuhrer/playermodel.mdl"},
    {name = "Obersturmführer", model = "models/kriegsyntax/germans/ss/cos/obersturmfuhrer/playermodel.mdl"},
    {name = "Hauptsturmführer", model = "models/kriegsyntax/germans/ss/cos/hauptsturmfuhrer/playermodel.mdl"},
	{name = "Sturmbannführer", model = "models/kriegsyntax/germans/ss/cos/sturmbannfuhrer/playermodel.mdl"},
    {name = "Obersturmbannführer", model = "models/kriegsyntax/germans/ss/cos/obersturmbannfuhrer/playermodel.mdl"},
    {name = "Standartenführer", model = "models/kriegsyntax/germans/ss/cos/standartenfuhrer/playermodel.mdl"},
    {name = "Oberführer", model = "models/kriegsyntax/germans/ss/cos/oberfuhrer/playermodel.mdl"},
	{name = "Brigadeführer", model = "models/kriegsyntax/germans/ss/cos/brigadefuhrer/playermodel.mdl"},
	{name = "Gruppenführer", model = "models/kriegsyntax/germans/ss/cos/gruppenfuhrer/playermodel.mdl"},
	{name = "Obergruppenführer", model = "models/kriegsyntax/germans/ss/cos/obergruppenfuhrer/playermodel.mdl"},
	{name = "Oberstgruppenführer", model = "models/kriegsyntax/germans/ss/cos/oberstgruppenfuhrer/playermodel.mdl"},
  },
  orpo = {
    {name = "Anwärter", model = "models/kriegsyntax/germans/ordnungspolizei/enlisted/mann/playermodel_2.mdl"},
    {name = "Unterwachtmeister", model = "models/kriegsyntax/germans/ordnungspolizei/enlisted/sturmmann/playermodel_2.mdl"},
    {name = "Rottmeister", model = "models/kriegsyntax/germans/ordnungspolizei/enlisted/rottenfuhrer/playermodel_2.mdl"},
	
    {name = "Wachtmeister", model = "models/kriegsyntax/germans/ordnungspolizei/ncos/unterscharfuhrer/playermodel_2.mdl"},
	{name = "Oberwachtmeister", model = "models/kriegsyntax/germans/ordnungspolizei/ncos/scharfuhrer/playermodel_2.mdl"},
	{name = "Zugwachtmeister", model = "models/kriegsyntax/germans/ordnungspolizei/ncos/oberscharfuhrer/playermodel_2.mdl"},
	{name = "Hauptwachtmeister", model = "models/kriegsyntax/germans/ordnungspolizei/ncos/hauptscharfuhrer/playermodel_2.mdl"},
	{name = "Meister", model = "models/kriegsyntax/germans/ordnungspolizei/ncos/stabsscharfuhrer/playermodel_3.mdl"},
	
	{name = "Leutnant der Polizei", model = "models/kriegsyntax/germans/ordnungspolizei/cos/untersturmfuhrer/playermodel.mdl"},
    {name = "Oberleutnant der Polizei", model = "models/kriegsyntax/germans/ordnungspolizei/cos/obersturmfuhrer/playermodel.mdl"},
    {name = "Hauptmann der Polizei", model = "models/kriegsyntax/germans/ordnungspolizei/cos/hauptsturmfuhrer/playermodel.mdl"},
    {name = "Major der Polizei", model = "models/kriegsyntax/germans/ordnungspolizei/cos/sturmbannfuhrer/playermodel.mdl"},
	{name = "Oberstleutnant der Polizei", model = "models/kriegsyntax/germans/ordnungspolizei/cos/obersturmbannfuhrer/playermodel.mdl"},
	{name = "Oberst der Polizei", model = "models/kriegsyntax/germans/ordnungspolizei/cos/standartenfuhrer/playermodel.mdl"},
	{name = "Generalmajor der Polizei", model = "models/kriegsyntax/germans/ordnungspolizei/cos/brigadefuhrer/playermodel.mdl"},
	{name = "Generalleutnant der Polizei", model = "models/kriegsyntax/germans/ordnungspolizei/cos/gruppenfuhrer/playermodel.mdl"},
	{name = "General der Polizei", model = "models/kriegsyntax/germans/ordnungspolizei/cos/obergruppenfuhrer/playermodel.mdl"},
	{name = "Generaloberst der Polizei", model = "models/kriegsyntax/germans/ordnungspolizei/cos/oberstgruppenfuhrer/playermodel.mdl"},
  },
  leib = {
    {name = "Mann", model = "models/kriegsyntax/germans/ss/lss/enlisted/schutze/playermodel.mdl"},
	{name = "Obermann", model = "models/kriegsyntax/germans/ss/lss/enlisted/oberschutze/playermodel.mdl"},
    {name = "Sturmmann", model = "models/kriegsyntax/germans/ss/lss/enlisted/sturmmann/playermodel.mdl"},
    {name = "Rottenführer", model = "models/kriegsyntax/germans/ss/lss/enlisted/rottenfuhrer/playermodel.mdl"},
  },
  doctor = {
    {name = "Intern", model = "models/suits/male_08_shirt_tie.mdl"},
    {name = "Nurse", model = "models/suits/male_09_shirt_tie.mdl"},
	{name = "Dentist", model = "models/suits/male_03_shirt_tie.mdl"},
    {name = "Doctor", model = "models/suits/male_04_shirt_tie.mdl"},
	{name = "Psychologist", model = "models/suits/male_05_shirt_tie.mdl"},
	{name = "Surgeon", model = "models/suits/male_02_shirt_tie.mdl"},
	{name = "Head of BDA", model = "models/suits/male_07_shirt_tie.mdl"},
  },
  marksman = {
    {name = "Waffen SS Scharfschütze ", model = "models/kriegsyntax/germans/waffenss_summer/enlisted/schutze/playermodel.mdl"},
    {name = "Waffen SS Scharfschützeschütze", model = "models/kriegsyntax/germans/waffenss_summer/enlisted/oberschutze/playermodel.mdl"},
    {name = "Waffen SS Sturmmann der Scharfschütze", model = "models/kriegsyntax/germans/waffenss_summer/enlisted/sturmmann/playermodel.mdl"},
    {name = "Waffen SS Rottenführer der Scharfschütze", model = "models/kriegsyntax/germans/waffenss_summer/enlisted/rottenfuhrer/playermodel.mdl"},

    {name = "Waffen SS Unterscharführer der Scharfschütze", model = "models/kriegsyntax/germans/waffenss_summer/ncos/unterscharfuhrer/playermodel_2.mdl"},
    {name = "Waffen SS Scharführer der Scharfschütze", model = "models/kriegsyntax/germans/waffenss_summer/ncos/scharfuhrer/playermodel_2.mdl"},
    {name = "Waffen SS Oberscharführer der Scharfschütze", model = "models/kriegsyntax/germans/waffenss_summer/ncos/oberscharfuhrer/playermodel_2.mdl"},
    {name = "Waffen SS Hauptscharführer der Scharfschütze", model = "models/kriegsyntax/germans/waffenss_summer/ncos/hauptscharfuhrer/playermodel_2.mdl"},
    {name = "Waffen SS Sturmscharführer der Scharfschütze", model = "models/kriegsyntax/germans/waffenss_summer/ncos/stabsscharfuhrer/playermodel_2.mdl"},

    {name = "Waffen SS Untersturmführer der Scharfschütze", model = "models/kriegsyntax/germans/waffenss_summer/cos/untersturmfuhrer/playermodel.mdl"},
    {name = "Waffen SS Obersturmführer der Scharfschütze", model = "models/kriegsyntax/germans/waffenss_summer/cos/obersturmfuhrer/playermodel.mdl"},
    {name = "Waffen SS Hauptsturmführer der Scharfschütze", model = "models/kriegsyntax/germans/waffenss_summer/cos/hauptsturmfuhrer/playermodel.mdl"},
    {name = "Waffen SS Sturmbannführer", model = "models/kriegsyntax/germans/waffenss/cos/sturmbannfuhrer/playermodel.mdl"},
    {name = "Waffen SS Obersturmbannführer", model = "models/kriegsyntax/germans/waffenss/cos/obersturmbannfuhrer/playermodel.mdl"},
    {name = "Waffen SS Standartenführer", model = "models/kriegsyntax/germans/waffenss/cos/standartenfuhrer/playermodel.mdl"},
    {name = "Waffen SS Oberführer", model = "models/kriegsyntax/germans/waffenss/cos/oberfuhrer/playermodel.mdl"},
  },
  waffen = {
    {name = "Schütze", model = "models/kriegsyntax/germans/waffenss/enlisted/schutze/playermodel.mdl"},
    {name = "Oberschütze", model = "models/kriegsyntax/germans/waffenss/enlisted/oberschutze/playermodel.mdl"},
    {name = "Sturmmann", model = "models/kriegsyntax/germans/waffenss/enlisted/sturmmann/playermodel.mdl"},
    {name = "Rottenführer", model = "models/kriegsyntax/germans/waffenss/enlisted/rottenfuhrer/playermodel.mdl"},

    {name = "Unterscharführer", model = "models/kriegsyntax/germans/waffenss/ncos/unterscharfuhrer/playermodel_2.mdl"},
    {name = "Scharführer", model = "models/kriegsyntax/germans/waffenss/ncos/scharfuhrer/playermodel_2.mdl"},
    {name = "Oberscharführer", model = "models/kriegsyntax/germans/waffenss/ncos/oberscharfuhrer/playermodel_2.mdl"},
    {name = "Hauptscharfuhrer", model = "models/kriegsyntax/germans/waffenss/ncos/hauptscharfuhrer/playermodel_2.mdl"},
    {name = "Sturmscharführer", model = "models/kriegsyntax/germans/waffenss/ncos/stabsscharfuhrer/playermodel_2.mdl"},

    {name = "Untersturmführer", model = "models/kriegsyntax/germans/waffenss/cos/untersturmfuhrer/playermodel.mdl"},
    {name = "Obersturmführer", model = "models/kriegsyntax/germans/waffenss/cos/obersturmfuhrer/playermodel.mdl"},
    {name = "Hauptsturmführer", model = "models/kriegsyntax/germans/waffenss/cos/hauptsturmfuhrer/playermodel.mdl"},
    {name = "Sturmbannführer", model = "models/kriegsyntax/germans/waffenss/cos/sturmbannfuhrer/playermodel.mdl"},
    {name = "Obersturmbannführer", model = "models/kriegsyntax/germans/waffenss/cos/obersturmbannfuhrer/playermodel.mdl"},
    {name = "Standartenführer", model = "models/kriegsyntax/germans/waffenss/cos/standartenfuhrer/playermodel.mdl"},
    {name = "Oberführer", model = "models/kriegsyntax/germans/waffenss/cos/oberfuhrer/playermodel.mdl"},
    {name = "Brigadeführer", model = "models/kriegsyntax/germans/waffenss/cos/brigadefuhrer/playermodel.mdl"},
    {name = "Gruppenführer", model = "models/kriegsyntax/germans/waffenss/cos/gruppenfuhrer/playermodel.mdl"},
    {name = "Obergruppenführer", model = "models/kriegsyntax/germans/waffenss/cos/obergruppenfuhrer/playermodel.mdl"},
    {name = "Oberstgruppenführer", model = "models/kriegsyntax/germans/waffenss/cos/oberstgruppenfuhrer/playermodel.mdl"},
  }
}

--META Library
local meta = FindMetaTable("Player")
function meta:getRank(div)
  for k,v in pairs(ranks[div]) do
      if self:GetModel():lower() == v.model:lower() then
      return v,k
    end
  end

  --Check if player might be in another div
  for name,list in pairs(ranks) do
    for k,v in pairs(list) do
      local check = string.match(self:Nick(), v.name, 1)
      if not check then continue end
      if check == v.name and self:GetModel() == v.model then
        return "notrightdiv", name
      end
    end
  end

  return nil
end
function meta:promote(div, id, new, divchange, olddiv)
  local rank = ranks[div][id]
  local name = self:Nick()
  local char = self:getChar()

  --Div change
  if divchange then
    local n,id = self:getRank(olddiv)
    local pure = string.gsub(name,n.name,"")
    char:setName(rank.name .. pure)
    char:setModel(rank.model)
    return
  end

  --Max rank
  if not rank then
    return "max"
  end

  --New rank
  if new then
    char:setName(rank.name .. " " .. name)
    char:setModel(rank.model)
    char:setFaction(FACTION_CLONES)
    return true
  end

  --Removing rank name
  local lastrank = ranks[div][id-1]

  --Setting new name
  char:setName(string.gsub(name, lastrank.name, rank.name))

  --Setting model
  char:setModel(rank.model)

  nut.util.notify("Your rank has changed to " .. rank.name, self)
end
function meta:demote(div, rank)
  local currank = ranks[div][rank+1]
  local tochange = ranks[div][rank]
  local char = self:getChar()
  local name = self:Nick()

  if not istable(tochange) then --Turn to recruit
    nut.util.notify("You have been turned to Recruit.", self)
    char:setModel("models/Humans/Group01/male_07.mdl")
    char:setName(string.gsub(name,currank.name .. " ",""))
    char:setFaction(FACTION_RECRUIT)
    return
  end

  nut.util.notify("Your rank have changed to " .. tochange.name, self)
  char:setModel(tochange.model)
  char:setName(tochange.name .. string.gsub(name,currank.name,""))
end

--Helpful functions
local function getDivision(s)
  for k,v in pairs(ranks) do
    if k:lower() == s:lower() then
      return k
    end
  end

  return nil
end

--Commands
nut.command.add("promote", {
  syntax = "<string ply> <string division> [boolean force]",
  adminOnly = true,
  onRun = function(ply, args)
    local target = nut.util.findPlayer(args[1])
    if not target then --If the players wasn't found
      nut.util.notify("Can't find player", ply)
    end

    --Finding Division
    local div = getDivision(args[2])
    local rank, id = target:getRank(div)
    if rank == "notrightdiv" and not args[3] then
      nut.util.notify("The division you specified is not the same as the target's, type '/promote " .. args[1] .. " " .. args[2] .. " true' to force change")
      return
    elseif rank == "notrightdiv" and args[3] then
      nut.util.notify(target:Nick() .. " have been set to " .. ranks[div][1].name .. " and have been changed to " .. div .. " division.")
      target:promote(div, 1, nil, true, id)
      return
    end

    -- print(rank, id)

    if not rank or not id then --If player is not ranked
      nut.util.notify("Player is not yet ranked, he will be placed as " .. ranks[div][1].name, ply)
      target:promote(div, 1, true)
      return
    else --If player is already ranked
      local err = target:promote(div, id+1)

      if err == "max" then
        nut.util.notify("The player is already at the max rank")
      end
    end
  end
})

nut.command.add("demote", {
  syntax = "<string ply> <string division>",
  adminOnly = true,
  onRun = function(ply, args)
    if not args[1] then
      nut.util.notify("You did not specify any target.", ply)
      return
    end
    if not args[2] then
      nut.util.notify("You did not specify the division.", ply)
      return
    end

    local target = nut.util.findPlayer(args[1])
    if not target then
      nut.util.notify("The player you specified wasn't found.", ply)
      return
    end

    --Get current rank
    local div = getDivision(args[2])
    local rank, id = target:getRank(div)
    if not rank or not id then
      nut.util.notify("The target isn't yet ranked.", ply)
      return
    end
    if not rank == "notrightdiv" then
      nut.util.notify("You did not specify the right division.", ply)
      return
    end

    target:demote(div, id-1)
  end
})