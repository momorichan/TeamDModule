<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- jstl �߰� -->
<%@include file="../temp/header.jsp"%>
<c:set var="rPath" value="${pageContext.request.contextPath}/resources" />
<article>
	<header style="color: white">Fileupload Demo</header>
	<ul class="list-unstyled">
		<li class="border-top my-3">FileList</li>
	</ul>
	<div class="container">
		<table class="table table-bordered" id="upboardTable">
			<thead>
				<tr>
					<th colspan="6"><select id="sv" name="sv">
							<option value="0">Search</option>
							<option value="1">hit</option>
							<option value="2">bdate</option>
					</select></th>
				</tr>
				<tr>
					<th>��ȣ</th>
					<th>�̹���</th>
					<th>��ǰ�̸�</th>
					<th>����</th>
					<th>�Һз�</th>
				</tr>
			</thead>
			<tbody>
			<tbody id="productlist">
				<c:forEach var="e" items="${list}">
					<tr>
						<!-- <th>��ȣ</th> -->
						<th scope="row">${e.pnum}</th>
						<td>�̹���</td>
						<td>${e.pname}</td>
						<td><fmt:formatNumber type="number" value="${e.price}" pattern="###,###" /></td>
					</tr>
				</c:forEach>
				<%-- for end --%>
			</tbody>
			<tfoot>
			<ul class="pagination">
				</ul>
			
				
				<%-- page���� --%>
				<%-- <%@include file="../temp/pageProcess.jsp"%> --%>
				<%-- �˻����� --%>
				<tr>
					<td colspan="6" style="text-align: right;">
						<button type="button" class="btn btn-outline-secondary" onclick="location='upform'">���ۼ�</button>
					</td>
				</tr>
			</tfoot>
		</table>

		<div class="searchArea">
			<input type="hidden" name="command" value="stList"> <select id="lcategory" name="lcategory" class="select-cate round-orange-hover">
				<option value="0">����</option>
				<c:forEach var="category" items="${lclist}">
					<option value="${category.lcnum}">${category.lcname}</option>
				</c:forEach>
			</select> <select id="scnum" name="scnum" class="select-cate round-orange-hover">
				<option value="">����</option>
			</select> <input class="select-keyword round-orange-hover" type="text" name="keyword" id="keyword" placeholder="Ű���� �Է�">
			<button type="submit" class="normal_bigbtn">�˻�</button>
			<button type="button" class="else_bigbtn" onclick="location='prList'">��ü �˻�</button>
		</div>
	</div>
</article>
<script>
$(document).ready(function() {
	searchValue = "";
	cPage = 1;
	page(searchValue, cPage);
	
	
	$(".pagination").on('click', '[id^="page"]', function(event) {
	    cPage = $(this).text();
	    page("", cPage);
	    console.log(cPage);
	});
	


$('#lcategory').on('change', function() {
	lcnumber = $(this).val();
	if(lcnumber == 0){
		$('#scnum').empty();
		$('#scnum').append('<option value="0">����</option>');
	}
	var begin = 1;
	var end = 10;
	page("", 1);
    console.log(lcnumber);
});


$('#scnum').on('change', function() {
	scnumber = $(this).val();
	var begin = 1;
	var end = 10;
	page("", 1);
    console.log(scnumber);
});


function page(searchValue, cPage) {
	var lcnum = $('#lcategory').val();
	var scnum = $('#scnum').val();
	console.log("lcnum : " + lcnum);
	console.log("scnum : " + scnum);
	if(scnum == ''){
		scnum = '0';
	}
	var pageUrl = "${cPath}/pagination?searchValue="+ searchValue +"&cPage=" + cPage;
	pageUrl += "&lcnum=" + lcnum + "&scnum=" + scnum;
	$.ajax({
        url: pageUrl,
        type: "get",
        dataType : 'json', 
        success: function(pageData) {
        	updatePage(pageData);
        	var begin = pageData.page.beginPerPage;
        	var end = pageData.page.endPerPage;
        	console.log("pageData.page.beginPerPage : " + begin);
        	console.log("pageData.page.endPerPage : " + end);
        	
        	if(scnum == '0' && lcnum == '0'){
        		lclistfunction(lcnum, begin, end);
        	}else if(scnum != '0'){
        		sclistfunction(scnum, begin, end);
        	}else{
        		lclistfunction(lcnum, begin, end);
        	}
        	console.log("��");
        },
    });
}

function updatePage(pageData) {
	console.log(pageData);
    let paginationHTML = '';

    // ���� ������ ��ũ
    if(pageData.page.nowPage > 1) {
        paginationHTML += '<li class="page-item"><button class="page-link" id="pagePrevious">Previous</button></li>';
    } else {
        paginationHTML += '<li class="page-item disabled"><button class="page-link" id="pagePrevious">Previous</button></li>';
    }
    
    // ������ ��ȣ
	for (let i = pageData.startPage; i <= pageData.endPage; i++) {
	    if (i === pageData.page.nowPage) {
	        paginationHTML += '<li class="page-item active"><button class="page-link" id="page'+ i +'">' + i + '</button></li>';
	    } else {
	        paginationHTML += '<li class="page-item"><button class="page-link" id="page'+ i +'">' + i + '</button></li>';
	    }
	}

    
    // ���� ������ ��ũ
    if(pageData.page.nowPage < pageData.page.totalPage) {
        paginationHTML += '<li class="page-item"><button class="page-link" id="pageNext">Next</button></li>';
    } else {
        paginationHTML += '<li class="page-item disabled"><button class="page-link" id="pageNext">Next</button></li>';
    }
    
    $(".pagination").html(paginationHTML);
}



function lclistfunction(selectedValue, begin, end) {
      
	lcurl = "${cPath}/prlcList?lcnum=" + selectedValue;
	lcurl += "&begin=" + begin + "&end=" + end;
       $.ajax({
           url: lcurl,
           type: "get",
           dataType : 'json', 
           success: function(listMap) {
        	   console.log(listMap);
        	   //ī�װ� �Һз��� ����Ѵ�.
        	   $('#scnum').empty();
        	   $('#scnum').append('<option value="0">����</option>');
        	 listMap.sclist.forEach(item => {
            	 var option = $('<option>');
                 option.val(item.scnum);
                 option.text(item.scname);
                 $('#scnum').append(option);
             });
        	   
        	   
        	   //���õ� ��з� ī�װ��� �ش��ϴ� ��ǰ�鸸 ��ǰ��Ͽ� �����Ѵ�.
        	   $('#productlist').empty();
        	 listMap.sprlist.forEach(item => {
        		 
            	 var tr = $('<tr>');
            	 var th = $('<th>');
            	 var td1 = $('<td>');
            	 var td2 = $('<td>');
            	 var td3 = $('<td>');
            	 var td4 = $('<td>');
            	 th.attr('scope', 'row');
            	 th.text(item.pnum);
            	 td1.text(item.image);
            	 td2.text(item.pname);
            	 td3.text(item.price);
            	 td4.text(item.scnum);
            	 tr.append(th).append(td1).append(td2).append(td3).append(td4);
                 $('#productlist').append(tr);
             });
           },
       });
}



function sclistfunction(selectedValue, begin, end) {
    
	scurl = "${cPath}/prscList?scnum=" + selectedValue;
	scurl += "&begin=" + begin + "&end=" + end;
	var lcValue = $("#lcategory").val();
    
	if(selectedValue == '0'){
		scurl += '&lcnum=' + lcValue;
	}
	
    $.ajax({
        url: scurl,
        type: "get",
        dataType : 'json', 
        success: function(sclist) {
      	   console.log(sclist);
     	   console.log("�̰� ����Ǵ� �ǰ�?");
     	   //���õ� ��з� ī�װ��� �ش��ϴ� ��ǰ�鸸 ��ǰ��Ͽ� �����Ѵ�.
     	   $('#productlist').empty();
     	  sclist.forEach(item => {
     		 
         	 var tr = $('<tr>');
        	 var th = $('<th>');
        	 var td1 = $('<td>');
        	 var td2 = $('<td>');
        	 var td3 = $('<td>');
        	 var td4 = $('<td>');
        	 th.attr('scope', 'row');
        	 th.text(item.pnum);
        	 td1.text(item.image);
        	 td2.text(item.pname);
        	 td3.text(item.price);
        	 td4.text(item.scnum);
        	 tr.append(th).append(td1).append(td2).append(td3).append(td4);
              $('#productlist').append(tr);
          });
        },
    });
}

});



</script>

<style>
.searchCls {
	color: orange;
	font-weight: bold;
}
</style>


