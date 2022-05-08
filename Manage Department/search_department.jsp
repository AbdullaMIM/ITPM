 <!DOCTYPE html>
<%@page import="java.sql.*"%>

<html lang="en">
	
	<head>
		<script>
			function confirmDelete()
			{
				return confirm("Do You Want to Delete This Department?");
			}
		</script>
	</head>
	
      <%@include file="header.jsp"%>
  
  
    
   <body>

      <div class="row">
    
      <%@include file="menu.jsp"%>
     
  
        
        
        
     <!-------   Content Area start  --------->
         <div class="col-md-10 maincontent" >

     
     <!-----------  Content Menu Tab Start   ------------>
         <div class="panel panel-default contentinside">
            
            <div class="panel-heading" style="font-size: 18px; font-weight: bold;">Manage Department</div>

     
     <!----------------   Panel Body Start   --------------->
        <div class="panel-body">
            <ul class="nav nav-tabs doctor">
                    <li role="presentation" style="font-size: 18px; font-weight: bold;"><a href="#doctorlist">Department List</a></li>
                    <li role="presentation" style="font-size: 18px; font-weight: bold;"><a href="#adddoctor">Add New Department</a></li>
            </ul>



      <!--------------------------------------------   Display Department Data List start   -----------------------------------------> 
         <div id="doctorlist" class="switchgroup">
              <table class="table table-bordered table-hover">
                  <tr class="active">
                           <td>Department ID</td>
                           <td>Department Name</td>
                           <td>Description</td>
                           <td>Options</td>
                  </tr>
<%!
		int deptId;
		String deptName;
		String deptDesc;
%>

<%
	    Connection c=(Connection)application.getAttribute("connection");
	    String searchString=request.getParameter("searchString");
	    PreparedStatement ps=c.prepareStatement("select * from department where name like '%"+searchString+"%'",ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	    ResultSet rs=ps.executeQuery();
	    while(rs.next())
	   {
		  deptId=rs.getInt(1);
		  deptName=rs.getString(2);
		  deptDesc=rs.getString(3);
		
%>
                   <tr>
                           <td><%=deptId%></td>
                           <td><%=deptName%></td>
                           <td><%=deptDesc%></td>
                           
                           <td>
						    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal<%=deptId%>"><span class="glyphicon glyphicon-wrench" aria-hidden="true"></span></button>
                            <a href="delete_dept_validation.jsp?deptId=<%=deptId%>" class="btn btn-danger" onclick="return confirmDelete()"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span></a>
						   </td>
                   </tr>
<%
	}
	rs.first();
	rs.previous();
%>

               
             </table>
          </div>  
     <!----------------------------------------   Display Department Data List ends ---------------------------------------->
        
        
        
     
     <!--------------------------------------  Edit Department Modal Starts Here -------------------------------------------------------------->
                   
<%
	while(rs.next())
	{
		deptId=rs.getInt(1);
		deptName=rs.getString(2);
		deptDesc=rs.getString(3);
		
%>   
              <div class="modal fade" id="myModal<%=deptId%>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                       
                    
                        <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel">Edit Department</h4>
                        </div>
                        
                        <div class="modal-body">
                        <div class="panel panel-default">
                            <div class="panel-body">
                             <form class="form-horizontal" method="post" action="edit_dept_validation.jsp">
                                    
                                <div class="form-group">
                                    <label  class="col-sm-3 control-label">Department ID</label>
                                    <div class="col-sm-8">
                                        <input type="number" class="form-control" name="deptId" value="<%=deptId%>" readonly="readonly">
                                    </div>
                                </div>
                                    
                                <div class="form-group">
                                    <label  class="col-sm-3 control-label">Department Name</label>
                                    <div class="col-sm-8">
                                      <input type="text" class="form-control" name="deptName" value="<%=deptName%>" required>
                                    </div>
                                 </div>

                                 <div class="form-group">
                                       <label class="col-sm-3 control-label">Description</label>
                                       <div class="col-sm-8">
                                         <input type="text" class="form-control" name="deptDesc" value="<%=deptDesc%>"  style="height: 50px" required>
                                       </div>
                                 </div>
                               
                                 <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                    <input type="submit" class="btn btn-primary" value="Update">
                                 </div>
                            </form>
                         </div>
                       </div>
                       </div>
                       
                    </div>
                 </div>
             
            </div>
<%
	}
%>
<!--------------------------------------  Edit Department Modal Ends Here -------------------------------------------------------------->
 
        
        
              
 <!-------------------------------------   Add Department Start Here -------------------------------------------------------------------->
               <div id="adddoctor" class="switchgroup">
                   <div class="panel panel-default">
                       <div class="panel-body">
                           
                           <form class="form-horizontal" method="post" action="add_dept_validation.jsp">
                            
                            <div class="form-group">
                                <label  class="col-sm-3 control-label">Department ID</label>
                                <div class="col-sm-7">
                                  <input type="number" class="form-control" name="deptId" placeholder="Auto-generated Unique ID" readonly>
                                </div>
                            </div>

                            <div class="form-group">
                                <label  class="col-sm-3 control-label">Department Name</label>
                                <div class="col-sm-7">
                                  <input type="text" class="form-control" name="deptName" placeholder="Enter Department Name" required>
                                </div>
                             </div>

                            <div class="form-group">
                                <label class="col-sm-3 control-label"> Description</label>
                                <div class="col-sm-7">
                                   <input type="text" class="form-control" name="deptDesc" placeholder="Enter Description About Department" style="height: 50px" required>
                                </div>
                            </div>


                            <div class="form-group">
                                <div class="col-sm-offset-5 col-sm-10">
                                  <button type="submit" class="btn btn-primary">Add Department</button>
                                </div>
                            </div>
                        
                        </form>
                    </div>
                  </div>
               </div>
  <!-------------------------------------   Add Department Ends Here ---------------------------------------------------- --------------->
                   
        </div>
 <!--------------------------------------  Panel Body Ends Here ------------------------------------------------------------------------>
   
    </div>
 <!--------------------------------------  Content Menu Tab Ends Here ------------------------------------------------------------------>

 </div>
<!----------------------------------------  Content Area Ends Here --------------------------------------------------------------------->
        
 </div>
  
        <script src="js/bootstrap.min.js"></script>
        
    </body>
</html>
