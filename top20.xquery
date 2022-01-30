<html>
    <body>
    <table border= "2">
    <tr>
        <th><i>Target</i></th>
        <th><i>Successor</i></th>
        <th><i>Probability</i></th>
    </tr>
{   
    let $has := for $s in collection(".?select=*.xml")//s
        return   
            for $w in $s/w
            return
                if(lower-case(normalize-space($w/text())) eq 'has') 
                    then
                        let $succ := (data($s/w[.>> $w][1]))
                        return
                             
                             <tuple> {lower-case(normalize-space($w/text()))} {','}{lower-case(normalize-space($succ))}</tuple>
                    else  ()

    let $corpus := for $s in collection(".?select=*.xml")//s
        return 
            for $w in $s/w
            return <word>{lower-case(normalize-space($w/text()))}</word>
         
    let $calc_probability := for $distinct in distinct-values($has/text())
        let $d := (($has[text() = $distinct])[1])
        
        let $arr := tokenize($d, ',')
        
        let $count := count($has[text() = $distinct])
        
        let $total_count := count($corpus[text()=$arr[2]])
        
        let $probability := round-half-to-even($count div $total_count, 2)
        
        order by $probability descending, $arr[2] ascending
        return
            <tr>
                <td>{$arr[1]}</td>
                <td>{$arr[2]}</td>
                <td>{$probability}</td>
            </tr>
         
    return
        for $x in subsequence($calc_probability, 1, 20)
            return $x
}
    </table>
    </body>
</html>
