<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import="com.hantaegune.web.*, java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Applications</title>
<link href="css/bootstrap.css" rel="stylesheet"/>
<script type="text/javascript" src="//code.jquery.com/jquery-1.9.1.js"></script>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script type='text/javascript'>//<![CDATA[

$(function () {
    $('#chart').highcharts({
        chart: {
            zoomType: 'xy'
        },
        title: {
            text: 'Average Monthly Temperature and Rainfall in Tokyo'
        },
        subtitle: {
            text: 'Source: WorldClimate.com'
        },
        xAxis: [{
            categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
            crosshair: true
        }],
        yAxis: [{ // Primary yAxis
            labels: {
                format: '{value}°C',
                style: {
                    color: Highcharts.getOptions().colors[1]
                }
            },
            title: {
                text: 'Temperature',
                style: {
                    color: Highcharts.getOptions().colors[1]
                }
            }
        }, { // Secondary yAxis
            title: {
                text: 'Rainfall',
                style: {
                    color: Highcharts.getOptions().colors[0]
                }
            },
            labels: {
                format: '{value} mm',
                style: {
                    color: Highcharts.getOptions().colors[0]
                }
            },
            opposite: true
        }],
        tooltip: {
            shared: true
        },
        legend: {
            layout: 'vertical',
            align: 'left',
            x: 120,
            verticalAlign: 'top',
            y: 100,
            floating: true,
            backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF'
        },
        series: [{
            name: 'Rainfall',
            type: 'column',
            yAxis: 1,
            data: [49.9, 71.5, 106.4, 129.2, 144.0, 176.0, 135.6, 148.5, 216.4, 194.1, 95.6, 54.4],
            tooltip: {
                valueSuffix: ' mm'
            }

        }, {
            name: 'Temperature',
            type: 'spline',
            data: [7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6],
            tooltip: {
                valueSuffix: '°C'
            }
        }]
    });
});
//]]> 
</script>
</head>
<body>
	<center><h1>TaiJun-Han Receipts</h1></center>
	<div id="chart" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
<%
	// Call Controller {
	ApplicationDAO dao = new ApplicationDAO();

	String action =request.getParameter("action");
	String name = request.getParameter("name");
	String price =request.getParameter("price");
	String id =request.getParameter("id");
	Application app =new Application();
	
	if("create".equals(action)){
		double priceD = Double.parseDouble(price);
		app = new Application(name,priceD);
		dao.create(app);
	}else if("remove".equals(action)){
		int idInt = Integer.parseInt(id);
		dao.remove(idInt);
		
	}else if("select".equals(action)){
		int idInt = Integer.parseInt(id);
		app= dao.selectOne(idInt);
	}else if("update".equals(action)){
		int idInt = Integer.parseInt(id);
		double priceD = Double.parseDouble(price);
		app = new Application(name,priceD);
		dao.update(idInt, app);
	}
	//}
	
	List<Application> applications =dao.selectAll();
%>

<form action="applications.jsp">
	<input type="hidden" name="id" value="<%=app.getId()%>"/>
	<table class="table">
	<tr>
		<td><input name="name" class="form-control" value="<%=app.getName()%>"/></td>
		<td><input name="price" class="form-control" value="<%=app.getPrice()%>"/></td>
		<td>
			<button class="btn btn-success" name="action" value="create">
				Add
			</button>
			<button class="btn btn-primary" name="action" value="update">
				Update
			</button>
		</td>
	</tr>
	<% 
		for(Application ap:applications) {
	%>	<tr>
		<td><%=ap.getName() %></td>
		<td><%=ap.getPrice() %></td>
		<td>
			<a class="btn btn-danger" href="applications.jsp?action=remove&id=<%=ap.getId() %>">
			Delete
			</a>
			<a class="btn btn-warning" href="applications.jsp?action=select&id=<%=ap.getId() %>">
			Selete
			</a>
			
		</td>

		</tr>
	<%
		}
	%>
	</table>
</form>
</body>
</html>