<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- jstl �߰� -->
<%@include file="../temp/header.jsp"%>
<c:set var="rPath" value="${pageContext.request.contextPath}/resources" />
<article>

	<div class="container">
		<h1>��ǰ ���</h1>
		<table class="table table-bordered" id="upboardTable">
			<thead>
				<tr>
					<th colspan="6">
						<div class="searchArea">
							<select id="lcnum" name="lcnum" class="select-cate round-orange-hover">
								<option value="0">����</option>
								<c:forEach var="category" items="${lclist}">
									<option value="${category.lcnum}">${category.lcname}</option>
								</c:forEach>
							</select> 
							<select id="scnum" name="scnum" class="select-cate round-orange-hover">
								<option value="">����</option>
							</select> 
							<input class="select-keyword round-orange-hover" type="text"
								name="keyword" id="productSearch" placeholder="Ű���� �Է�">
							<button type="submit" class="normal_bigbtn" id="productSearchBtn">�˻�</button>
						</div>
					</th>
				</tr>
				<tr>
					<th>��ȣ</th>
					<th>�̹���</th>
					<th>��ǰ�̸�</th>
					<th>����</th>
					<th>�Һз�</th>
				</tr>
			</thead>
			<tbody id="productlist">
				<%-- ��ǰ��� �� �ڸ� (ajax) --%>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="6">
						<ul class="pagination">
							<%-- ����¡ �� �ڸ� (ajax) --%>
						</ul>
					</td>
				</tr>
			</tfoot>
		</table>
	</div>
</article>
<script>
$(document).ready(function() {
   searchValue = ""; // �˻��� ��
   cPage = 1; // ������ ������(�ʱⰪ)
   page("lcnum", searchValue, cPage);
      
   // ���̵� page�� �� ��ư�� Ŭ���ϸ� �ش�Ǵ� ��ư�� �ؽ�Ʈ�� �������� pagenation Ŭ������ �߰�
   $(".pagination").on('click', '[id^="page"]', function(event) {
	    cPage = $(this).text(); 
	    var key = "lcnum";
	    if($('#scnum').val() != '0'){
	       key = "scnum";
	    }
	    
	    var searchValue = $('#productSearch').val();
/* 	    searchValue = encodeURIComponent(searchValue); */
	    
	    page(key, searchValue, cPage);

	});

$('#productSearchBtn').on('click', function(event) {
    cPage = 1;
    var key = "lcnum";
    if($('#scnum').val() != '0'){
       key = "scnum";
    }
    var searchValue = $('#productSearch').val();
    /* searchValue = encodeURIComponent(searchValue); */
    
    page(key, searchValue, cPage);
});


$('#lcnum').on('change', function() {
   lcnumber = $(this).val();
   $('#scnum').empty();
   $('#productSearch').val('');
   $('#scnum').append('<option value="0">����</option>');
   
   var begin = 1;
   var end = 10;
   var key = "lcnum";
   page(key, "", 1);
});


$('#scnum').on('change', function() {
   scnumber = $(this).val();
   $('#productSearch').val('');
   var begin = 1;
   var end = 10;
   var key = "scnum";
   page(key, "", 1);
});


function page(key, searchValue, cPage) {
   var lcnum = $('#lcnum').val();
   var scnum = $('#scnum').val();
   if(scnum == ''){
      scnum = '0';
   }
   

	// ajax �� ���� url ����
   var pageUrl = "${cPath}/pagination?searchValue="+ searchValue +"&cPage=" + cPage; 
   pageUrl += "&lcnum=" + lcnum + "&scnum=" + scnum;
   
   // ������ �������� ���� Ȥ�� ���� �϶� url�� �Ķ���� currPage(���������� ��ȣ) �߰�
   if(cPage == 'Previous' || cPage == 'Next'){
      pageUrl += "&currPage=" + $('.currPage').text();
   }
   
   // ajax ���
   $.ajax({
        url: pageUrl,
        type: "get",
        dataType : 'json', 
        success: function(pageData) {
           updatePage(pageData);
           var begin = pageData.page.beginPerPage;
           var end = pageData.page.endPerPage;
           categorylistfunction(key, begin, end, searchValue);
        },
    });
}

function updatePage(pageData) {
   console.log(pageData);
    let paginationHTML = '';

    // ���� ������ ��ũ
    if(pageData.startPage > pageData.page.pagePerBlock) {
        paginationHTML += '<li class="page-item"><button class="page-link" id="pagePrevious">Previous</button></li>';
    } else {
        paginationHTML += '<li class="page-item disabled"><button class="page-link" id="pagePrevious">Previous</button></li>';
    }
    
    // ������ ��ȣ
   for (let i = pageData.startPage; i <= pageData.endPage; i++) {
       if (i === pageData.page.nowPage) {
           paginationHTML += '<li class="page-item active"><button class="page-link currPage" id="page'+ i +'">' + i + '</button></li>';
       } else {
           paginationHTML += '<li class="page-item"><button class="page-link" id="page'+ i +'">' + i + '</button></li>';
       }
   }

    // ���� ������ ��ũ 
    if(pageData.endPage < pageData.page.totalPage) {
        paginationHTML += '<li class="page-item"><button class="page-link" id="pageNext">Next</button></li>';
    } else {
        paginationHTML += '<li class="page-item disabled"><button class="page-link" id="pageNext">Next</button></li>';
    }
    
    $(".pagination").html(paginationHTML);
}

function categorylistfunction(key, begin, end, searchValue) {
	// ī�װ� ���� ������
   var lcnum = $("#lcnum").val();
   var scnum = $("#scnum").val();
   // url ����
   url = "${cPath}/prCaList?begin=" + begin + "&end=" + end + "&searchValue=" + searchValue;
   
   // ��з��� �������� ��� �Һз� ���� 0���� ����
   if(key == 'lcnum'){
	   scnum = '0';
   }
   url += "&lcnum=" + lcnum + "&scnum=" + scnum + "&key=" + key;
       $.ajax({
           url: url,
           type: "get",
           dataType : 'json', 
           success: function(listMap) {
              console.log(listMap);
              
              
              if(listMap.sclist && listMap.sclist.length > 0){  
                 //ī�װ� �Һз��� ����Ѵ�.
                 $('#scnum').empty();
                 $('#scnum').append('<option value="0">����</option>');
               listMap.sclist.forEach(item => {
                   var option = $('<option>');
                    option.val(item.scnum);
                    option.text(item.scname);
                    $('#scnum').append(option);
                });
              }      
            //���õ� ��з� ī�װ��� �ش��ϴ� ��ǰ�鸸 ��ǰ��Ͽ� �����Ѵ�.
            $('#productlist').empty();
            listMap.sprlist.forEach(item => {
                var tr = $('<tr>');
                var th = $('<th>');
                var td1 = $('<td>');
                var img = $('<img>');
                var td2 = $('<td>');
                var a = $('<a>');
                var td3 = $('<td>');
                var td4 = $('<td>');
                th.attr('scope', 'row');
                th.text(item.pnum);
                // �̹��� ������Ʈ ����
                img.attr('src', '${rPath}/imgfile/'+item.image);
                img.attr('alt', 'Product Image'); // alt �Ӽ� �߰� (�̹��� ��ü �ؽ�Ʈ)
                
                a.attr('href', '${cPath}/prDetail?pnum=' + item.pnum);
                a.text(item.pname);
                td3.text(item.price.toLocaleString()+" ��");
                td4.text(item.scnum);
                // <img> ������Ʈ�� <td1> ������Ʈ�� �߰�
                td1.append(img);
                td2.append(a);
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

img {
	max-height: 100px;
}
</style>

