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
				<%-- page���� --%>
				<%@include file="../temp/pageProcess.jsp"%>
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

			<button type="button" class="else_bigbtn" onclick="searchAll();">��ü �˻�</button>
		</div>
	</div>
</article>
<script>
function lclistfunction(selectedValue) {
      
       $.ajax({
           url: "${cPath}/prlcList?lcnum=" + selectedValue,
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
            	 th.attr('scope', 'row');
            	 th.text(item.pnum);
            	 td1.text(item.pname);
            	 td2.text(item.price);
            	 tr.append(th).append(td1).append(td2);
                 $('#productlist').append(tr);
             });
           },
       });
}
$('#lcategory').on('change', function() {
	lcnumber = $(this).val();
	if(lcnumber == 0){
		$('#scnum').empty();
		$('#scnum').append('<option>����</option>');
	}
	lclistfunction(lcnumber);
    console.log(lcnumber);
});


$('#scnum').on('change', function() {
	scnumber = $(this).val();
    sclistfunction(scnumber);
    console.log(scnumber);
});


function sclistfunction(selectedValue) {
    
	scurl = "${cPath}/prscList?scnum=" + selectedValue;
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
         	 th.attr('scope', 'row');
         	 th.text(item.pnum);
         	 td1.text(item.pname);
         	 td2.text(item.price);
         	 tr.append(th).append(td1).append(td2);
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


