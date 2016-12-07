<speakers>
{
for $a in doc('j_caesar.xml')/PLAY/ACT/SCENE/SPEECH/SPEAKER
let $s := $a/text()
group by $s
order by count($a)

return <character count="{count($a)}">{$s}</character>
}
</speakers>