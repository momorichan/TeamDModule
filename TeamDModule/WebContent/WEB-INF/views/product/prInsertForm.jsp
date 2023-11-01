<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ include file = "../temp/header.jsp"%>


<article>
   <div class="container">
      <h2>��ǰ ���</h2>
      <p>�����ڰ� ������ ��ǰ�� ����ϴ� �������Դϴ�.</p>
      <form action="prAdd" method="post" enctype="multipart/form-data">
         <div class="input-group">
            <span class="input-group-text">��ǰ �̸�</span>
            <input class="form-control" type="text" id="pname" name="pname">            
         </div>
         <div class="input-group">
            <span class="input-group-text">�̹���01</span>
            <input class="form-control" type="file" id="mfile1" name="mfile1">            
         </div>
         <div class="input-group">
            <span class="input-group-text">�̹���02</span>
            <input class="form-control" type="file" id="mfile2" name="mfile2">            
         </div>
         <div class="input-group">
            <span class="input-group-text">�̹���03</span>
            <input class="form-control" type="file" id="mfile3" name="mfile3">            
         </div>
         <div class="input-group">
            <span class="input-group-text">��� ����</span>
            <input class="form-control" type="number" id="stock" name="stock">            
         </div>
         <div class="input-group">
            <span class="input-group-text">�ܰ�</span>
            <input class="form-control" type="number" id="price" name="price">            
         </div>
         <div class="input-group">
            <span class="input-group-text">��з�ī�װ�</span>
            <select id="lcategory" name="lcategory" class="form-select">
               <c:forEach var="category" items="${lclist}"> 
                  <option value="${category.lcnum}">${category.lcname}</option>
               </c:forEach>
            </select>            
         </div>
         <div class="input-group">
            <span class="input-group-text">�Һз�ī�װ�</span>
            <select id="scnum" name="scnum" class="form-select">
               
            </select>            
         </div>
         <div class="input-group">
            <span class="input-group-text">��ǰ �� ����</span>
            <input class="form-control" type="text" id="pdetail" name="pdetail">            
         </div>         
         <div id="buttonset" class="input-group">
            <button type="submit" class="btn btn-primary btn-lg"> 
               ���
            </button>
            &nbsp;&nbsp;&nbsp;
            <button type="reset" class="btn btn-secondary btn-lg">�ʱ�ȭ</button>
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