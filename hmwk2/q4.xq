<result>
{for $s in distinct-values(//SPEAKER/text())
where every $a in //ACT  satisfies (exists($a//SPEAKER[text()=$s]))
order by $s
return <character>{$s}</character>}
</result>