<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ include file = "../temp/header.jsp"%>


<article>
   <div class="container">
      <h2>상품 등록</h2>
      <p>관리자가 구매할 상품을 등록하는 페이지입니다.</p>
      <form action="prAdd" method="post" enctype="multipart/form-data">
         <div class="input-group">
            <span class="input-group-text">상품 이름</span>
            <input class="form-control" type="text" id="pname" name="pname" required="required">             
         </div>
         <div class="input-group">
            <span class="input-group-text">이미지01</span>
            <input class="form-control" type="file" id="mfile1" name="mfile1" required="required">            
         </div>
         <div class="input-group">
            <span class="input-group-text">이미지02</span>
            <input class="form-control" type="file" id="mfile2" name="mfile2">            
         </div>
         <div class="input-group">
            <span class="input-group-text">이미지03</span>
            <input class="form-control" type="file" id="mfile3" name="mfile3">            
         </div>
         <div class="input-group">
            <span class="input-group-text">재고 수량</span>
            <input class="form-control" type="number" id="stock" name="stock" required="required">            
         </div>
         <div class="input-group">
            <span class="input-group-text">단가</span>
            <input class="form-control" type="number" id="price" name="price" required="required">            
         </div>
         <div class="input-group">
            <span class="input-group-text">대분류카테고리</span>
            <select id="lcategory" name="lcategory" class="form-select">
               <c:forEach var="category" items="${lclist}"> 
                  <option value="${category.lcnum}">${category.lcname}</option>
               </c:forEach>
            </select>            
         </div>
         <div class="input-group">
            <span class="input-group-text">소분류카테고리</span>
            <select id="scnum" name="scnum" class="form-select">
               
            </select>            
         </div>
         <div class="input-group">
            <span class="input-group-text">상품 상세 설명</span>
            <input class="form-control" type="text" id="pdetail" name="pdetail" required="required">            
         </div>         
         <div id="buttonset" class="input-group">
            <button type="submit" class="btn btn-primary btn-lg"> 
               등록
            </button>
            &nbsp;&nbsp;&nbsp;
            <button type="reset" class="btn btn-secondary btn-lg">초기화</button>
         </div>
      </form>
   </div>
   <script>
   $(document).ready(function() {
      sclistfunction($('#lcategory').val());
   });
   function sclistfunction(selectedValue) {
         $('#scnum').empty();
          $.ajax({
              url: "${cPath}/sclist?lcnum=" + selectedValue,
              type: "get",
              dataType : 'json', 
              success: function(sclist) {
                 sclist.forEach(item => {
                    var option = $('<option>');
                    option.val(item.scnum);
                    option.text(item.scname);
                    $('#scnum').append(option);
                });
              },
          });
   }
   $('#lcategory').on('change', function() {
       sclistfunction($(this).val());
   });

   </script>
</article>