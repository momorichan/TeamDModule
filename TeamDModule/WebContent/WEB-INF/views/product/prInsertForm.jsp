<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ include file = "../temp/header.jsp"%>

<article>
   <div class="container">
      <h2>상품 등록</h2>
      <p>관리자가 구매할 상품을 등록하는 페이지입니다.</p>
      <form action="" method="post" enctype="multipart/form-data">
         <div class="input-group">
            <span class="input-group-text">상품 이름</span>
            <input class="form-control" type="text" id="name" name="name">            
         </div>
         <div class="input-group">
            <span class="input-group-text">이미지01</span>
            <input class="form-control" type="file" id="image01" name="image01">            
         </div>
         <div class="input-group">
            <span class="input-group-text">이미지02</span>
            <input class="form-control" type="file" id="image02" name="image02">            
         </div>
         <div class="input-group">
            <span class="input-group-text">이미지03</span>
            <input class="form-control" type="file" id="image03" name="image03">            
         </div>
         <div class="input-group">
            <span class="input-group-text">재고 수량</span>
            <input class="form-control" type="number" id="stock" name="stock">            
         </div>
         <div class="input-group">
            <span class="input-group-text">단가</span>
            <input class="form-control" type="number" id="price" name="price">            
         </div>
         <div class="input-group">
            <span class="input-group-text">대분류카테고리</span>
            <select id="lcategory" name="lcategory" class="form-select">
               <c:forEach var="category" items="${lclist}"> 
                  <option id="lcnum" value="${category.lcnum}">${category.lcname}</option>
               </c:forEach>
            </select>            
         </div>
         <div class="input-group">
            <span class="input-group-text">소분류카테고리</span>
            <select id="scategory" name="scategory" class="form-select">
               <c:forEach var="category" items="${sclist}"> 
                  <option value="${category.scnum}">${category.scname}</option>
               </c:forEach>
            </select>            
         </div>
         <div class="input-group">
            <span class="input-group-text">상품 상세 설명</span>
            <input class="form-control" type="text" id="contents" name="contents">            
         </div>         
         <div id="buttonset" class="input-group">
            <button type="submit" class="btn btn-primary btn-lg"
               onclick="return validCheck();">등록
            </button>
            &nbsp;&nbsp;&nbsp;
            <button type="reset" class="btn btn-secondary btn-lg">초기화</button>
         </div>
      </form>
   </div>
</article>
<script>
$('#lcategory').on('change', function() {
	var selectedValue = $(this).val();
    $.ajax({
        url: "/sclist?lcnum=" + selectedValue,
        type: "get",
        success: function(response) {
            // 성공적으로 데이터를 받았을 때의 처리
        },
        error: function(error) {
            // 오류가 발생했을 때의 처리
        }
    });
});
	
</script>