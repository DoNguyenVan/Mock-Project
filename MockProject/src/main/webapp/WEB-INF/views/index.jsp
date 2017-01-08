<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
 
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style>

label.error {
	 display:inline-block;
	 color:red;
	 width: 200px;
	 font-style: italic;
	 font-size: 14px;
	 }
	 
  #form-add-employee  {
      margin-left:10%;
      width: 80%;       
      border: solid black 1px;      
  }

  table  td {
       padding: 10px;
  }
    	
lable{
  font-style: normal;
  font-size: 14px;
  color: black;
  font:bold;
}
	 
h2{
  font-size: 30px;
  margin-left: 2%;
  font-style: oblique; 
}

#btn-submit{
  margin-top: 5px;
  margin-left: 16%;
  margin-bottom: 15px;
}
#search-form{
  margin-bottom:2%;
  margin-right: 15px;

}
#tittle{
  margin-left: 10%;
}
.panel-heading{
  height: 10px;
}

//phan tran
//------------------------------------------
ul{border:0; margin:0; padding:0;}

#pagination-flickr li{
border:0; margin:0; padding:0;
font-size:11px;
list-style:none;
}

#pagination-flickr a{
border:solid 1px #DDDDDD;
margin-right:2px;
}

#pagination-flickr .previous-off,
#pagination-flickr .next-off{
color:#666666;
display:block;
float:left;
font-weight:bold;
padding:3px 4px;
}

#pagination-flickr .next a,
#pagination-flickr .previous a{
font-weight:bold;
border:solid 1px #FFFFFF;
}

#pagination-flickr .active{
color:#ff0084;
font-weight:bold;
display:block;
float:left;
padding:4px 6px;
}

#pagination-flickr a:link,
#pagination-flickr a:visited{
color:#0063e3;
display:block;
float:left;
padding:3px 6px;
text-decoration:none;
}

#pagination-flickr a:hover{
border:solid 1px #666666;
}
//-----------------------------------
</style>

</head>
<body>

<div class="container">
  <div class="panel panel-info">
    <div class="panel-heading"><center><h1>EMPLOYEES MANAGEMENT</h1></center></div>
    <div class="panel-body"> 
        <div class="pull-right">
          <lable>User : ${account.firstname}</lable>
          <a href="${pageContext.request.contextPath}/logout"><button class="btn btn-default">Logout</button></a>  
        </div>
    </div> 
    
    <div class="panel-body">        
         <div id="tittle"><h3>Create Employee Form</h3> </div>
		   <form:form action="save" method="POST" modelAttribute="employeeForm" id="employeeForm" >		
		        
		       <table id="form-add-employee">

		         <tr>
		           <td>MaNV</td>
		           <td>
		              <form:input path="id" class="form-control" id="id"/>
		           </td>
		           <td>Email</td>
		           <td>
		             <form:input path="email" class="form-control" id="email"/>
		           </td>
		         </tr>
		        
		         <tr>
		           <td>First Name</td>
		           <td>
		              <form:input path="firstname" class="form-control" id="firstname"/>
		           </td>
		           <td>Phone</td>
		           <td>
		             <form:input path="phone" class="form-control" id ="phone"/>
		           </td>
		         </tr>
		        
		         <tr>
		           <td>Last Name</td>
		           <td>
		             <form:input path="lastname" class="form-control" id="lastname" />
		           </td>
		           <td>DOB</td>
		           <td>
		              <form:input path="dob" class="form-control" id="dob"  />
		           </td>
		         </tr>	
		         <tr>
		          <td colspan="4">
		             <input type="submit" value="Commit (Add or Edit)" class="btn btn-danger" id="btn-submit"/>
		          </td>
		         </tr>	         
		       </table>		       		      	       
		   </form:form>       
    </div>
    
    
	  <div class="panel panel-default">   
	   <div class="panel-info">	      
	        <h2>List Of Employees</h2>
	        <div class="form-inline pull-right"  id="search-form">
	         <select class="form-control">
	            <option value="First_name" label="First_Name"/>
	            <option value="Last_Name" label="Last_Name"/>
	            <option value="Phone" label="Phone"/>
	            <option value="birthday" label="DOB"/>
	         </select>	        
	          <input type="text" class="form-control" size="70" />
	            <button class="btn btn-primary">Search</button>
	        </div> 
	   </div> 
	    <div class="panel-body">
	    
	      <table class="table table-bordered">
			 <tr>
			   <th>No</th>
			   <th>MaNV <a href="#"><span class="glyphicon glyphicon-chevron-down pull-right"></span></a></th>
			   <th>First_Name <a href="#"><span class="glyphicon glyphicon-chevron-down pull-right"></span></a> </th>
			   <th>Last_Name <a href="#"><span class="glyphicon glyphicon-chevron-down pull-right"></span></a></th>
			   <th>Email <a href="#"><span class="glyphicon glyphicon-chevron-down pull-right"></span></a></th>
			   <th>Phone <a href="#"><span class="glyphicon glyphicon-chevron-down pull-right"></span></a></th>
			   <th>DOB <a href="#"><span class="glyphicon glyphicon-chevron-down pull-right"></span></a></th>
			   <th colspan="2"><center>Action</center></th>
			 </tr>
			 
			 <c:forEach items="${emplist}" var="info">
			 
			 <tr>
			   <td>1</td>
			   <td> ${info.id}  </td>
			   <td> ${info.firstname}  </td>
			   <td> ${info.lastname} </td>
			   <td> ${info.email} </td>
			   <td> ${info.phone} </td>
			   <td> ${info.dob} </td>
			   <td> <a href="delete?id=${info.id}">Delete</a> </td>
			   <td> <a href="edit?id=${info.id}">Edit</a> </td>
			 </tr>    
			 
			 </c:forEach>
			</table>  
		
		<ul class="pagination pull-right">
		   <li><a href=""> <<  </a></li>
		   <li><a href=""> < </a></li>
		   <li> <a href="">1 </a></li>
		   <li><a href=""> 2 </a></li>
		   <li> <a href="">></a> </li>
		   <li> <a href="">>> </a></li>      
		</ul>	
										
			  
	    </div>
	  </div>  
       
  </div>
</div>
   
</body>
</html>