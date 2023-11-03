<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- jstl 추가 -->
<%@include file="../temp/header.jsp"%>
<c:set var="rPath" value="${pageContext.request.contextPath}/resources" />
<article>

	<div class="container">
		<h1>상품 목록</h1>
		<table class="table table-bordered" id="upboardTable">
			<thead>
				<tr>
					<th colspan="6">
						<div class="searchArea">
							<select id="lcnum" name="lcnum" class="select-cate round-orange-hover">
								<option value="0">선택</option>
								<c:forEach var="category" items="${lclist}">
									<option value="${category.lcnum}">${category.lcname}</option>
								</c:forEach>
							</select> 
							<select id="scnum" name="scnum" class="select-cate round-orange-hover">
								<option value="">없음</option>
							</select> 
							<input class="select-keyword round-orange-hover" type="text"
								name="keyword" id="productSearch" placeholder="키워드 입력">
							<button type="submit" class="normal_bigbtn" id="productSearchBtn">검색</button>
						</div>
					</th>
				</tr>
				<tr>
					<th>번호</th>
					<th>이미지</th>
					<th>상품이름</th>
					<th>가격</th>
					<th>소분류</th>
				</tr>
			</thead>
			<tbody id="productlist">
				<%-- 상품목록 들어갈 자리 (ajax) --%>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="6">
						<ul class="pagination">
							<%-- 페이징 들어갈 자리 (ajax) --%>
						</ul>
					</td>
				</tr>
			</tfoot>
		</table>
	</div>
</article>
<script>
$(document).ready(function() {
   searchValue = ""; // 검색할 값
   cPage = 1; // 목적지 페이지(초기값)
   page("lcnum", searchValue, cPage);
      
   // 아이디에 page가 들어간 버튼을 클릭하면 해당되는 버튼의 텍스트를 가져오고 pagenation 클래스에 추가
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
   $('#scnum').append('<option value="0">없음</option>');
   
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
   

	// ajax 를 위한 url 설정
   var pageUrl = "${cPath}/pagination?searchValue="+ searchValue +"&cPage=" + cPage; 
   pageUrl += "&lcnum=" + lcnum + "&scnum=" + scnum;
   
   // 목적지 페이지가 이전 혹은 다음 일때 url에 파라미터 currPage(현재페이지 번호) 추가
   if(cPage == 'Previous' || cPage == 'Next'){
      pageUrl += "&currPage=" + $('.currPage').text();
   }
   
   // ajax 통신
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

    // 이전 페이지 링크
    if(pageData.startPage > pageData.page.pagePerBlock) {
        paginationHTML += '<li class="page-item"><button class="page-link" id="pagePrevious">Previous</button></li>';
    } else {
        paginationHTML += '<li class="page-item disabled"><button class="page-link" id="pagePrevious">Previous</button></li>';
    }
    
    // 페이지 번호
   for (let i = pageData.startPage; i <= pageData.endPage; i++) {
       if (i === pageData.page.nowPage) {
           paginationHTML += '<li class="page-item active"><button class="page-link currPage" id="page'+ i +'">' + i + '</button></li>';
       } else {
           paginationHTML += '<li class="page-item"><button class="page-link" id="page'+ i +'">' + i + '</button></li>';
       }
   }

    // 다음 페이지 링크 
    if(pageData.endPage < pageData.page.totalPage) {
        paginationHTML += '<li class="page-item"><button class="page-link" id="pageNext">Next</button></li>';
    } else {
        paginationHTML += '<li class="page-item disabled"><button class="page-link" id="pageNext">Next</button></li>';
    }
    
    $(".pagination").html(paginationHTML);
}

function categorylistfunction(key, begin, end, searchValue) {
	// 카테고리 값을 가져옴
   var lcnum = $("#lcnum").val();
   var scnum = $("#scnum").val();
   // url 생성
   url = "${cPath}/prCaList?begin=" + begin + "&end=" + end + "&searchValue=" + searchValue;
   
   // 대분류가 선태했을 경우 소분류 값을 0으로 만듬
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
                 //카테고리 소분류를 등록한다.
                 $('#scnum').empty();
                 $('#scnum').append('<option value="0">선택</option>');
               listMap.sclist.forEach(item => {
                   var option = $('<option>');
                    option.val(item.scnum);
                    option.text(item.scname);
                    $('#scnum').append(option);
                });
              }      
            //선택된 대분류 카테고리에 해당하는 상품들만 상품목록에 노출한다.
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
                // 이미지 엘리먼트 설정
                img.attr('src', '${rPath}/imgfile/'+item.image);
                img.attr('alt', 'Product Image'); // alt 속성 추가 (이미지 대체 텍스트)
                
                a.attr('href', '${cPath}/prDetail?pnum=' + item.pnum);
                a.text(item.pname);
                td3.text(item.price.toLocaleString()+" 원");
                td4.text(item.scnum);
                // <img> 엘리먼트를 <td1> 엘리먼트에 추가
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

