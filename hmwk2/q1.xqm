for $a in doc('j_caesar.xml')/PLAY/ACT/SCENE/SPEECH
where $a/LINE = "Et tu, Brute! Then fall, Caesar."


return
<result>
  <answer>
    <who>{$a/SPEAKER/text()}</who>
    <when>{$a/../../TITLE/text()}</when>
  </answer>
</result>