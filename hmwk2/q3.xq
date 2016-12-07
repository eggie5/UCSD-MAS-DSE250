for $speech in doc('j_caesar.xml')//SPEAKER
group by $d := $speech/text()
order by $d

return 
<result>
<who>{$d}</who>
<when>{$speech/../../../TITLE/text()} </when>
</result>