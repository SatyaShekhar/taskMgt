<HTML>
<HEAD>
<TITLE>Expandable and collapsible table - demo</TITLE>
<script type="text/javascript">

function toggle_visibility(tbid,lnkid) {
	alert("tag name " + document.getElementsByTagName);
if (document.getElementsByTagName) {
  var tables = document.getElementsByTagName('table');
  alert(tables.length);
  for (var i = 0; i < tables.length; i++) {
   if (tables[i].id == tbid){
     var trs = tables[i].getElementsByTagName('tr');
     alert(trs);
     for (var j = 2; j < trs.length; j+=1) {
     trs[j].bgcolor = '#CCCCCC';
       if(trs[j].style.display == 'none')  {
          trs[j].style.display = '';
          alert("xx" + trs[j]);
       } else {
          trs[j].style.display = 'none';
          alert("yyyyyy");
       }
    }
   }
  }
 }
   var x = document.getElementById(lnkid);
   if (x.innerHTML == '[+] Expand ')
      x.innerHTML = '[-] Collapse ';
   else 
      x.innerHTML = '[+] Expand ';
}
</script>

<style type="text/css">
td {FONT-SIZE: 75%; MARGIN: 0px; COLOR: #000000;}
td {FONT-FAMILY: verdana,helvetica,arial,sans-serif}
a {TEXT-DECORATION: none;}
</style>

</head>

<BODY>
    <table width="800" border="0" align="center" cellpadding="4" cellspacing="0" id="tbl1" name="tbl1">
        <tr><td height="1" bgcolor="#727272" colspan="3"></td></tr>
        <tr bgcolor="#EEEEEE"><td height="15" colspan="2"> <strong>Project name 1</strong></td>
            <td bgcolor="#EEEEEE"><a href="javascript:toggle_visibility('tbl1','lnk1');">
            <div align="right" id="lnk1" name="lnk1">[+] Expand </div></a></td></tr>
        <tr style="{display='none'}"><td colspan="3"><div align="left">Short summary which describes Project 1.</div></td></tr>
        <tr style="{display='none'}" bgcolor="#EEEEEE"><td width="70%">File Name</td><td width="15%">Size</td><td  width="15%"></td></tr>

            <tr style="{display='none'}"><td>Document 1 of the project 1.doc</td><td>209.5 KB</td><td><a href="#">Download</a></td></tr>
            <tr style="{display='none'}"><td colspan="3" bgcolor="#CCCCCC" height="1"></td></tr>

            <tr style="{display='none'}"><td>Document 2 of the project 1.doc</td><td>86 KB</td><td><a href="#">Download</a></td></tr>
            <tr style="{display='none'}"><td colspan="3" bgcolor="#CCCCCC" height="1"></td></tr>

            <tr style="{display='none'}"><td>Document 3 of the project 1.doc</td><td>325.5 KB</td><td><a href="#">Download</a></td></tr>
            <tr style="{display='none'}"><td colspan="3" bgcolor="#CCCCCC" height="1"></td></tr>

            <tr style="{display='none'}"><td height="1" bgcolor="#CCCCCC" colspan="3"></td></tr>
            <tr style="{display='none'}"><td height="1" bgcolor="#727272" colspan="3"></td></tr>

            <tr style="{display='none'}"><td height="8" colspan="3"></td></tr>
     </table>

    <table width="800" border="0" align="center" cellpadding="4" cellspacing="0" id="tbl2" name="tbl2">
        <tr><td height="1" bgcolor="#727272" colspan="3"></td></tr>
        <tr bgcolor="#EEEEEE"><td height="15" colspan="2"> <strong>Project name 2</strong></td>
            <td bgcolor="#EEEEEE"><a href="javascript:toggle_visibility('tbl2','lnk2');">
            <div align="right" id="lnk2" name="lnk2">[+] Expand </div></a></td></tr>
        <tr style="{display='none'}"><td colspan="3"><div align="left">Short summary which describes Project 2.</div></td></tr>
        <tr style="{display='none'}" bgcolor="#EEEEEE"><td width="70%">File Name</td><td width="15%">Size</td><td  width="15%"></td></tr>

            <tr style="{display='none'}"><td>Document 1 of the project 2.doc</td><td>209.5 KB</td><td><a href="#">Download</a></td></tr>
            <tr style="{display='none'}"><td colspan="3" bgcolor="#CCCCCC" height="1"></td></tr>

            <tr style="{display='none'}"><td>Document 2 of the project 2.doc</td><td>86 KB</td><td><a href="#">Download</a></td></tr>
            <tr style="{display='none'}"><td colspan="3" bgcolor="#CCCCCC" height="1"></td></tr>

            <tr style="{display='none'}"><td height="1" bgcolor="#CCCCCC" colspan="3"></td></tr>
            <tr style="{display='none'}"><td height="1" bgcolor="#727272" colspan="3"></td></tr>

            <tr style="{display='none'}"><td height="8" colspan="3"></td></tr>
     </table>
</body>
</html>