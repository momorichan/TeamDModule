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
	
	
	$('[id^="page"]').on('click', function(event) {
        cPage = $(this).text();
        page("", cPage);
        console.log(cPage);
    });
	
 });

$('#lcategory').on('change', function() {
	lcnumber = $(this).val();
	if(lcnumber == 0){
		$('#scnum').empty();
		$('#scnum').append('<option>����</option>');
	}
	var begin = 1;
	var end = 10;
	lclistfunction(lcnumber, begin, end);
    console.log(lcnumber);
});


$('#scnum').on('change', function() {
	scnumber = $(this).val();
	var begin = 1;
	var end = 10;
    sclistfunction(scnumber, begin, end);
    console.log(scnumber);
});


function page(searchValue, cPage) {
	var lcnum = $('#lcategory').val();
	var scnum = $('#scnum').val();
	var pageUrl = "${cPath}/pagination?searchValue=${searchValue}&cPage=" + cPage;
	pageUrl += "&lcnum=" + lcnum + "&scnum=" + scnum;
	$.ajax({
        url: pageUrl,
        type: "get",
        dataType : 'json', 
        success: function(pageData) {
        	updatePage(pageData);
        },
    });
}

function updatePage(pageData) {
    let paginationHTML = '';

    // ���� ������ ��ũ
    if(pageData.currentPage > 1) {
        paginationHTML += '<li class="page-item"><a class="page-link" href="#" onclick="fetchPaginationData(' + (data.currentPage - 1) + ', \'�˻���\')">Previous</a></li>';
    } else {
        paginationHTML += '<li class="page-item disabled"><a class="page-link" href="#">Previous</a></li>';
    }
    
    // ������ ��ȣ
    for (let i = 1; i <= pageData.totalPages; i++) {
        if (i === pageData.currentPage) {
            paginationHTML += '<li class="page-item active"><a class="page-link" href="#">' + i + '</a></li>';
        } else {
            paginationHTML += '<li class="page-item"><a class="page-link" href="#" onclick="fetchPaginationData(' + i + ', \'�˻���\')">' + i + '</a></li>';
        }
    }
    
    // ���� ������ ��ũ
    if(pageData.currentPage < pageData.totalPages) {
        paginationHTML += '<li class="page-item"><a class="page-link" href="#" onclick="fetchPaginationData(' + (data.currentPage + 1) + ', \'�˻���\')">Next</a></li>';
    } else {
        paginationHTML += '<li class="page-item disabled"><a class="page-link" href="#">Next</a></li>';
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





</script>

<style>
.searchCls {
	color: orange;
	font-weight: bold;
}
</style>


