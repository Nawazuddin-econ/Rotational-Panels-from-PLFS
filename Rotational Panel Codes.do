**************************************************
**********************2017-18*********************

cd "D:\Hard Drive\toshiba_PLFS\2017_18"
infile using "D:\Hard Drive\toshiba_PLFS\2017_18\HHFV.dct",clear
isid fsu samplesbno sssno shno
gen hhid=fsu+samplesbno+sssno+shno
bysort hhid: gen dup=cond(_N==1, 0, _n)
save hh_fv_17_18
infile using "D:\Hard Drive\toshiba_PLFS\2017_18\HHRV.dct",clear
isid fsu samplesbno sssno shno
gen hhid=fsu+samplesbno+sssno+shno
bysort hhid: gen dup=cond(_N==1, 0, _n)
save hh_rv_17_18

infile using "D:\Hard Drive\toshiba_PLFS\2017_18\PERFV.dct",clear
isid fsu samplesbno sssno shno prsn_srl
gen hhid=fsu+samplesbno+sssno+shno
gen psid=hhid+prsn_srl
save per_fv_17_18

infile using "D:\Hard Drive\toshiba_PLFS\2017_18\PERRV.dct",clear
isid fsu samplesbno sssno shno prsn_srl
gen hhid=fsu+samplesbno+sssno+shno
gen psid=hhid+prsn_srl
save per_rv_17_18

use hh_fv_17_18,clear
merge 1:m hhid using per_fv_17_18
drop _merge
save hhind_fv_17_18

use hh_rv_17_18,clear
merge 1:m hhid visit using per_rv_17_18
drop _merge
save hhind_rv_17_18

*______Making Rotational Panel_1_______*

use hhind_fv_17_18,clear //First Visit HH and Individual Merged File
gen panelid="P11" if quartr=="Q1"  //Create Panel id
replace panelid="P12" if quartr=="Q2" 
replace panelid="P13" if quartr=="Q3" 
replace panelid="P14" if quartr=="Q4" 
**Give Prefix to all variables: 'fv' stands for first visit 
foreach x of var * {
		rename `x' fv_`x' 
}
**However for merging remove prefix from the following variables
ren (fv_hhid fv_psid fv_panelid) (hhid psid panelid)
**since rotational panel is only for urban areas, keep urban data only**
keep if fv_sect=="2"
save fv_17_18

use hhind_rv_17_18,clear //Revisit HH and Individual Merged File
gen panelid="P11" if quartr=="Q2" & visit=="V2" //Create Panel Ids as we did in 'first visit' file 
replace panelid="P11" if quartr=="Q3" & visit=="V3"
replace panelid="P11" if quartr=="Q4" & visit=="V4"
replace panelid="P12" if quartr=="Q3" & visit=="V2"
replace panelid="P12" if quartr=="Q4" & visit=="V3"
replace panelid="P13" if quartr=="Q4" & visit=="V2"
***Now give prefix to variables 'rv' for revisit
foreach x of var * {
		rename `x' rv_`x' 
}
***Again remove prefix from some variables
ren (rv_hhid rv_psid rv_panelid) (hhid psid panelid)

save rv_17_18 //save as revisit file

***Merge first visit and revisit file
use fv_17_18,clear
merge 1:m panelid psid using rv_17_18

***Don't run: it's output
Result	# of obs.
	
not matched	51,386
from master	49,416	(_merge==1)
from using	1,970	(_merge==2)

matched	270,590	(_merge==3)
***************

save rotational_1_17_18 //this is first rotational panel
*****************Repeat same with 2018-19 with some additional steps*****************************
**************2018-2019***********************
cd "F:\toshiba_PLFS\2018_19"

infile using "F:\toshiba_PLFS\2018_19\HHfv_18_19.dct",clear
isid fsu samplesbno sssno shno
gen hhid=fsu+samplesbno+sssno+shno
bysort hhid: gen dup=cond(_N==1, 0, _n)
save hh_fv_18_19

infile using "F:\toshiba_PLFS\2018_19\HHrv_18_19.dct",clear
isid fsu samplesbno sssno shno
gen hhid=fsu+samplesbno+sssno+shno
bysort hhid: gen dup=cond(_N==1, 0, _n)
save hh_rv_18_19

infile using "F:\toshiba_PLFS\2018_19\PERfv_18_19.dct",clear
isid fsu samplesbno sssno shno prsn_srl
gen hhid=fsu+samplesbno+sssno+shno
gen psid=hhid+prsn_srl
save per_fv_18_19

infile using "F:\toshiba_PLFS\2018_19\PERrv_18_19.dct",clear
isid fsu samplesbno sssno shno prsn_srl visit
gen hhid=fsu+samplesbno+sssno+shno
gen psid=hhid+prsn_srl
save per_rv_18_19

use hh_fv_18_19,clear
merge 1:m hhid using per_fv_18_19
drop _merge
save hhind_fv_18_19

use hh_rv_18_19,clear
merge 1:m hhid visit using per_rv_18_19
drop _merge
save hhind_rv_18_19

*______Making Rotational Panel_2_______*

use hhind_fv_18_19,clear //use first visit HH and Individual merged file
gen panelid="P15" if quartr=="Q5"  //create panel Id
replace panelid="P16" if quartr=="Q6" 
replace panelid="P17" if quartr=="Q7" 
replace panelid="P18" if quartr=="Q8" 
***Give Prefix
foreach x of var * {
		rename `x' fv_`x' 
}

ren (fv_hhid fv_psid fv_panelid) (hhid psid panelid)
**Keep Urban Data Only
keep if fv_sect=="2"
save fv_18_19

use hhind_rv_18_19,clear
gen panelid="P14" if quartr=="Q5" & visit=="V2" //Generate Panel ID
replace panelid="P13" if quartr=="Q5" & visit=="V3"
replace panelid="P12" if quartr=="Q5" & visit=="V4"
replace panelid="P15" if quartr=="Q6" & visit=="V2"
replace panelid="P14" if quartr=="Q6" & visit=="V3"
replace panelid="P13" if quartr=="Q6" & visit=="V4"
replace panelid="P16" if quartr=="Q7" & visit=="V2"
replace panelid="P15" if quartr=="Q7" & visit=="V3"
replace panelid="P14" if quartr=="Q7" & visit=="V4"
replace panelid="P17" if quartr=="Q8" & visit=="V2"
replace panelid="P16" if quartr=="Q8" & visit=="V3"
replace panelid="P15" if quartr=="Q8" & visit=="V4"

**Give Prefix
foreach x of var * {
		rename `x' rv_`x' 
}

ren (rv_hhid rv_psid rv_panelid) (hhid psid panelid)

save rv_18_19

**Merge First Visit and Re-visit File
use fv_18_19,clear
merge 1:m panelid psid using rv_18_19

**Don't Run: It is output
Result	# of obs.
	

		_merge
panelid	master on	using onl	matched (	Total
				
P12			0			44,208			0			44,208 
P13			0			88,880			0			88,880 
P14			0			133,380			0			133,380 
P15			776			836				131,739		133,351 
P16			943			466				87,781		89,190 
P17			9			149				45,825		45,983 
P18			44,846		0				0			44,846 
				
Total		46,574		267,919			265,345		579,838 

save rotational_2_18_19 //This is the second file
********************Repeat above steps with 2019-2020 data**************************
**************2019-2020***********************

cd "F:\toshiba_PLFS\2019-2020"

infile using "F:\toshiba_PLFS\2019-2020\HHfv_19_20.dct",clear
isid fsu samplesbno sssno shno
gen hhid=fsu+samplesbno+sssno+shno
bysort hhid: gen dup=cond(_N==1, 0, _n)
save hh_fv_19_20

infile using "F:\toshiba_PLFS\2019-2020\HHrv_19_20.dct",clear
isid fsu samplesbno sssno shno visit
gen hhid=fsu+samplesbno+sssno+shno
bysort hhid: gen dup=cond(_N==1, 0, _n)
save hh_rv_19_20

infile using "F:\toshiba_PLFS\2019-2020\PERfv_19_20.dct",clear
isid fsu samplesbno sssno shno prsn_srl
gen hhid=fsu+samplesbno+sssno+shno
gen psid=hhid+prsn_srl
save per_fv_19_20

infile using "F:\toshiba_PLFS\2019-2020\PERrv_19_20.dct",clear
isid fsu samplesbno sssno shno prsn_srl visit
gen hhid=fsu+samplesbno+sssno+shno
gen psid=hhid+prsn_srl
save per_rv_19_20

use hh_fv_19_20,clear
merge 1:m hhid using per_fv_19_20
drop _merge
save hhind_fv_19_20

use hh_rv_19_20,clear
merge 1:m hhid visit using per_rv_19_20
drop _merge
save hhind_rv_19_20

*______Making Rotational Panel_3_______*
cd "F:\toshiba_PLFS\2019-2020"

use hhind_fv_19_20,clear
gen panelid="P21" if quartr=="Q1" 
replace panelid="P22" if quartr=="Q2" 
replace panelid="P23" if quartr=="Q3" 
replace panelid="P24" if quartr=="Q4" 

foreach x of var * {
		rename `x' fv_`x' 
}

ren (fv_hhid fv_psid fv_panelid) (hhid psid panelid)
keep if fv_sect=="2"

save fv_19_20

use hhind_rv_19_20,clear
gen panelid="P21" if quartr=="Q2" & visit=="V2"
replace panelid="P21" if quartr=="Q3" & visit=="V3"
replace panelid="P21" if quartr=="Q4" & visit=="V4"
replace panelid="P16" if quartr=="Q1" & visit=="V4"
replace panelid="P22" if quartr=="Q3" & visit=="V2"
replace panelid="P22" if quartr=="Q4" & visit=="V3"
replace panelid="P17" if quartr=="Q1" & visit=="V3"
replace panelid="P17" if quartr=="Q2" & visit=="V4"
replace panelid="P23" if quartr=="Q4" & visit=="V2"
replace panelid="P18" if quartr=="Q1" & visit=="V2"
replace panelid="P18" if quartr=="Q2" & visit=="V3"
replace panelid="P18" if quartr=="Q3" & visit=="V4"

foreach x of var * {
		rename `x' rv_`x' 
}

ren (rv_hhid rv_psid rv_panelid) (hhid psid panelid)

save rv_19_20

use fv_19_20,clear
merge 1:m panelid psid using rv_19_20


.	tab panelid _merge

		_merge
	panelid  master on	using onl	matched (	Total
				
	P16          0	43,010		0			43,010 
	P17          0	89,508		0			89,508 
	P18          0	130,646		0			130,646 
	P21        429	943			130,537		131,909 
	P22        977	392			86,438		87,807 
	P23      1,391	122			41,567		43,080 
	P24     44,447	0			0			44,447 
				
Total     47,244	264,621		258,542		570,407 


save rotational_3_19_20


**************Creating Visit-wise Files. We can directly start combining visit-wise files from Step 1 as an alternative*************************
cd "F:\Hard_Drive_Toshiba\toshiba_PLFS\2018_19"
use "rotational_2_18_19",clear
append using "F:\Hard_Drive_Toshiba\toshiba_PLFS\2019-2020\rotational_3_19_20.dta", gen(_mmerge)
sort psid panelid rv_visit
bysort psid panelid: gen dup=cond(_N==1,0,_n)
br hhid psid panelid *_age dup *_visit
br hhid psid panelid *_age dup *_visit  _mm
gen a="12" if panelid=="P12"
replace a="13" if panelid=="P13"
replace a="14" if panelid=="P14"
replace a="15" if panelid=="P15"
replace a="16" if panelid=="P16"
replace a="17" if panelid=="P17"
replace a="18" if panelid=="P18"
replace a="19" if panelid=="P19"
replace a="20" if panelid=="P20"
replace a="21" if panelid=="P21"
replace a="22" if panelid=="P22"
replace a="23" if panelid=="P23"

egen uniq_id=concat(psid a)
gen visit=rv_visit
replace visit=fv_visit if missing(visit)
isid uniq_id visit
save sample

use sample,clear
keep if fv_visit=="V1"
bysort uniq_id  : gen dup2=cond(_N==1,0,_n)
tab dup2
keep if dup2<=1
isid uniq_id
renpfix fv_ V1_
drop rv_*
save sample_V1

use sample,clear
keep if rv_visit=="V2"
isid uniq_id
renpfix rv_ V2_
drop fv_*
save sample_V2


use sample,clear
keep if rv_visit=="V3"
isid uniq_id
renpfix rv_ V3_
drop fv_*
save sample_V3


use sample,clear
keep if rv_visit=="V4"
isid uniq_id
renpfix rv_ V4_
drop fv_*
save sample_V4

use sample_V1,clear
merge m:1 uniq_id using sample_V2, gen(_mV1)
br hhid psid panelid *_age  *_visit  *_quartr uniq_id  _mV1
merge m:1 uniq_id using sample_V3, gen(_mV2)
br hhid psid panelid *_age  *_visit  *_quartr uniq_id  _mV1 _mV2
merge m:1 uniq_id using sample_V4, gen(_mV3)
br hhid psid panelid *_age  *_visit  *_quartr uniq_id  _mV1 _mV2 _mV3
isid uniq_id
drop V1_dup dup2 V2_dup V3_dup V4_dup visit
save final_rot_1819_1920

****Cross-Check
sort panelid
br hhid psid panelid *_age  *_visit  *_quartr uniq_id  _mV1 _mV2 _mV3
*P12 should have V1, V2 and V3 missing because thier data is in 2017-18
*P13 should have V1 and V2 missing because thier data is in 2017-18
*P14 should have V1 missing because thier data is in 2017-18
*P15, P16, P17 and P18 should have values for all visits (V1, V2, V3, V4)
*P21 also should have values for all visits (V1, V2, V3, V4)
*P22 should have V4 missing because thier data is in 2020-21. We do not consider PLFS-2020-21. You can extend.
*P23 should have V3 and V4 missing because thier data is in 2020-21. We do not consider PLFS-2020-21. You can extend.
*P22 should have V2, V3 and V4 missing because thier data is in 2020-21. We do not consider PLFS-2020-21. You can extend.
