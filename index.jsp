<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
     <script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
   <script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="build/table-edits.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>


<style>
.filterable {
    margin-top: 15px;
}
.filterable .panel-heading .pull-right {
    margin-top: -20px;
}
.filterable .filters input[disabled] {
    background-color: transparent;
    border: none;
    cursor: auto;
    box-shadow: none;
    padding: 0;
    height: auto;
}
.filterable .filters input[disabled]::-webkit-input-placeholder {
    color: #333;
}
.filterable .filters input[disabled]::-moz-placeholder {
    color: #333;
}
.filterable .filters input[disabled]:-ms-input-placeholder {
    color: #333;
}
</style>

</head>
<body>
<br>
<hr>
<INPUT type="button" value="Add Row" onclick="addRow('dataTable')" />

<INPUT type="button" value="Delete Row" onclick="deleteRow('dataTable')" />
<hr>
<div class="container">
    <div class="row">
        <div class="panel panel-primary filterable">
            <div class="panel-heading">
                <h3 class="panel-title">List of Employees</h3>
                <div class="pull-right">
                    <button class="btn btn-default btn-xs btn-filter"><span class="glyphicon glyphicon-filter"></span> Filter</button>
                </div>
            </div>
<table class = "table table-bodered" >
<thead>
  <tr class="filters">
    <th><input type="text" class="form-control" placeholder="Id" disabled></th>
     <th><input type="text" class="form-control" placeholder="First_Name" disabled></th>
     <th><input type="text" class="form-control" placeholder="Last_Name" disabled></th>
     <th><input type="text" class="form-control" placeholder="Email" disabled></th>
     <th><input type="text" class="form-control" placeholder="Phone" disabled></th>
     <th><input type="text" class="form-control" placeholder="DOB" disabled></th>
    <th>Action</th>
  </tr>
</thead>  
  <tbody>
    <c:forEach items="${emplist}" var="list">
     <tr>
        <td>${list.id}</td>
        <td>${list.firstname }</td>
        <td>${list.lastname }</td>
        <td>${list.email }</td>
        <td>${list.phone }</td>
        <td>${list.dob }</td>
        <td><a class="delete_single">delete</a></td>
     </tr>
    </c:forEach>
  </tbody>
 
</table>
</div>
    </div>
</div>

<script type="text/javascript">

$(document).ready(function(){
	
	// fitter
	 $('.filterable .btn-filter').click(function(){
        var $panel = $(this).parents('.filterable'),
        $filters = $panel.find('.filters input'),
        $tbody = $panel.find('.table tbody');
        if ($filters.prop('disabled') == true) {
            $filters.prop('disabled', false);
            $filters.first().focus();
        } else {
            $filters.val('').prop('disabled', true);
            $tbody.find('.no-result').remove();
            $tbody.find('tr').show();
        }
    });

    $('.filterable .filters input').keyup(function(e){
        /* Ignore tab key */
        var code = e.keyCode || e.which;
        if (code == '9') return;
        /* Useful DOM data and selectors */
        var $input = $(this),
        inputContent = $input.val().toLowerCase(),
        $panel = $input.parents('.filterable'),
        column = $panel.find('.filters th').index($input.parents('th')),
        $table = $panel.find('.table'),
        $rows = $table.find('tbody tr');
        /* Dirtiest filter function ever ;) */
        var $filteredRows = $rows.filter(function(){
            var value = $(this).find('td').eq(column).text().toLowerCase();
            return value.indexOf(inputContent) === -1;
        });
        /* Clean previous no-result if exist */
        $table.find('tbody .no-result').remove();
        /* Show all rows, hide filtered ones (never do that outside of a demo ! xD) */
        $rows.show();
        $filteredRows.hide();
        /* Prepend no-result row if all rows are filtered */
        if ($filteredRows.length === $rows.length) {
            $table.find('tbody').prepend($('<tr class="no-result text-center"><td colspan="'+ $table.find('.filters th').length +'">No result found</td></tr>'));
        }
    });
    
	// end fitter
	
	function toggleChecked(status) {
		  $(".checkbox").each( function() {
		  	$(this).attr("checked",status);
		  })
		}

	$('a.delete_single').on("click", function(event){	
		        var $this = $(this);
		        var c = confirm('Are you sure to delete this message?');
		           if(c) {
		            $this.parents('tr').fadeOut(function(){
		            $this.remove();
		           });
		        }
		        return false;
		});
 
	
	$('.deleteall').on("click", function(event){
		    var tb = $(this).attr('title');
		    var sel = false;
		    var ch = $('#'+tb).find('tbody input[type=checkbox]');
		    var c = confirm('Continue delete?');
		    if(c) {
		      ch.each(function(){
		         var $this = $(this);
		            if($this.is(':checked')) {
		                sel = true; //set to true if there is/are selected row
		                $this.parents('tr').fadeOut(function(){
		                $this.remove(); //remove row when animation is finished
		                });
		            }
		      });
		          if(!sel) alert('No data selected');
		    }
		    return false;
		});

	
	
});

</script>
</body>
</html>