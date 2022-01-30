 <html>
  <body>
   <table border="2">
     <tr><th>Target</th>
         <th>Successor</th>
         <th>Frequency</th></tr>
          {
           let $str := "has",
               $w := collection(".?select=*.xml")//w[lower-case(normalize-space()) = $str]
           for $unique in distinct-values($w/lower-case(normalize-space(following-sibling::w[1])))
           let $frequency := $w/lower-case(normalize-space(following-sibling::w[1]))[. = $unique]
           order by count($frequency) descending
           return
           <tr>
             <td> { $str } </td>
             <td> { $unique } </td>
              <td> { count($frequency) } </td>
            </tr>
          }
         </table>
    </body>
</html> 
