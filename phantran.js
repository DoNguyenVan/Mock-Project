function Pager(tableName, itemsPerPage) {
    this.tableName = tableName;
    this.itemsPerPage = itemsPerPage;
    this.currentPage = 1;
    this.pages = 0;
    this.inited = false;
   
    this.showRecords = function(from, to) {      
        var rows = document.getElementById(tableName).rows;
        // i starts from 1 to skip table header row
        for (var i = 1; i < rows.length; i++) {
            if (i < from || i > to)
                rows[i].style.display = 'none';
            else
                rows[i].style.display = '';
        }
    }
   
    this.showPage = function(pageNumber) {
          if (! this.inited) {
                   alert("not inited");
                   return;
          }
 
        var oldPageAnchor = document.getElementById('pg'+this.currentPage);
        oldPageAnchor.className = 'pg-normal';
       
        this.currentPage = pageNumber;
        var newPageAnchor = document.getElementById('pg'+this.currentPage);
        newPageAnchor.className = 'pg-selected';
       
        var from = (pageNumber - 1) * itemsPerPage + 1;
        var to = from + itemsPerPage - 1;
        this.showRecords(from, to);
    }  
   
    this.prev = function() {
        if (this.currentPage > 1)
            this.showPage(this.currentPage - 1);
    }
   
    this.next = function() {
        if (this.currentPage < this.pages) {
            this.showPage(this.currentPage + 1);
        }
    }                      
   
    this.init = function() {
        var rows = document.getElementById(tableName).rows;
        var records = (rows.length - 1);
        this.pages = Math.ceil(records / itemsPerPage);
        this.inited = true;
    }
 
    this.showPageNav = function(pagerName, positionId) {
          if (! this.inited) {
                   alert("not inited");
                   return;
          }
          var element = document.getElementById(positionId);              
         
            	var pagerHtml = '<span onclick="' + pagerName + '.prev();" class="pg-normal"> &#171 Prev </span> | ';            	
	            for (var page = 1; page <= this.pages; page++){ 
	            	            	
	            	 pagerHtml += '<span id="pg' + page + '" class="pg-normal" onclick="' + pagerName + '.showPage(' + page + ');">' + page + '</span> | ';
	            }
	            pagerHtml += '<span onclick="'+pagerName+'.next();" class="pg-normal"> Next &#187;</span>';   
         
	     
        element.innerHTML = pagerHtml;
    }
}



//cach dung
/*
<table id="haha">
     <tr>
          <th>Heading 1</th>
          <th>Heading 2</th>
          <th>Heading 3</th>
     </tr>
    <%int i=1;while(i<1000){ %> 
     <tr>
          <td>Column 1 – Row 1</td>
          <td>Column 2 – Row 1</td>
          <td>Column 3 – Row 1</td>
     </tr>
    <%i++;} %>
</table>
<div id="pageNavPosition"></div>
<script type="text/javascript">
       var pager = new Pager('haha', 13);
       pager.init();
       pager.showPageNav('pager', 'pageNavPosition');
       pager.showPage(1);
</script>*/
//css
/*
.pg-normal {
       color: red;
       font-weight: normal;
       text-decoration: none;  
       cursor: pointer;  
}
.pg-selected {
       color: black;
       font-weight: bold;      
       text-decoration: underline;
       cursor: pointer;
}*/