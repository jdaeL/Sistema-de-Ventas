#!C:\xampp\perl\bin\perl.exe
use strict;
use warnings;
use CGI;


my $q = CGI->new;

my $preciototal=0;
my $totalobjetos=0;
my $name=$q->param('nombre');

## conectar y pasar datos a maridb con login o sin login. 
## se puede generar un codigo random y eso pasarlo a mariadb e imprimirlo en la boleta




#imprimir html 
print "Content-type: text/html\n\n";
print <<HTML; 
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <title>Lista del Comprador</title>
    <link rel="icon" type="image/svg" href="../imgs/icon.png"/>
    <link rel="stylesheet" href="../css/estilos.css">
    <link rel="stylesheet" href="../css/responsive-table.css">

HTML

my $pro1=$q->param('producto1');
my $pro2=$q->param('producto2');
my $pro3=$q->param('producto3');
my $pro4=$q->param('producto4');
my $pro5=$q->param('producto5');
my $pro6=$q->param('producto6');
my $pro7=$q->param('producto7');
my $pro8=$q->param('producto8');
my $pro9=$q->param('producto9');
my $pro10=$q->param('producto10');
$preciototal=$pro1*98+$pro2*110+$pro3*96+$pro4*199+$pro5*230+$pro6*200+$pro7*120+$pro8*2200+$pro9*3600+$pro10*5600;
$totalobjetos=$pro1+$pro2+$pro3+$pro4+$pro5+$pro6+$pro7+$pro8+$pro9+$pro10;

print <<HTML    
</head>
<body>
    <br><br>
    <h1 style="text-align: center;">Boleta de venta</h1>
    <table>
        <tr>
            <td>Nombre del Producto</td>
            <td>Cantidad</td>
        </tr>
        <tr>
            <td>Mouse Logitech</td>
            <td>$pro1</td>
        </tr>
        <tr>
            <td>Mouse Razer</td>
            <td>$pro2</td>
        </tr>
        <tr>
            <td>Mouse HiperX</td>
            <td>$pro3</td>
        </tr>
        <tr>
        <tr>
            <td>Teclado Logitech</td>
            <td>$pro4</td>
        </tr>
        <tr>
            <td>Teclado Razer</td>
            <td>$pro5</td>
        </tr>
        <tr>
            <td>Teclado HiperX</td>
            <td>$pro6</td>
        </tr>
        <tr>
            <td>Audifonos HiperX</td>
            <td>$pro7</td>
        </tr>
        <tr>
            <td>PC 1</td>
            <td>$pro8</td>
        </tr>
        <tr>
            <td>PC 2</td>
            <td>$pro9</td>
        </tr>
        <tr>
            <td>PC 3</td>
            <td>$pro10</td>
        </tr>

        <tr>
    </table> 
    <table>
        <td>Precio total    >>>>>    $preciototal</td>
    </table> <br>
    <button style="margin:auto; display:block;" onclick="window.print()">Imprimir boleta</button>
</body>
HTML
