<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<div class="content">
	<div class="card-header">
        <h3><b>내 정보</b></h3>
   </div>
   
   <div class="card-body">

          <div class="form-group">
              <label for="exampleInputEmail1">E-mail</label>
              <input type="text" class="form-control" id="memberEmail" placeholder="${nowUser.member_email }" readonly>
              <small id="emailHelp" class="form-text text-muted">이메일 주소는 변경할 수 없습니다. </small>
          </div><br>
          <div class="form-group beforeSpan">
              <label for="exampleInputEmail1"><b>닉네임</b></label>
              <input type="text" class="form-control" id="memberName" maxlength=10 value="${nowUser.member_name }" readonly>
              <small id="numberlHelp" class="form-text text-muted"></small>
              <a href="javascript:setNameInput();" class="btn btn-primary btn-sm btn-block" style="width:150px" id="nickChangeBtn"><i class="far fa-edit"></i> 닉네임 변경</a>
          </div><br>
          <div class="form-group beforeSpan">
              <label for="exampleInputEmail1"><b>교회 출입 바코드</b></label>
              <input type="hidden" value="${nowUser.member_pass }" id="memberPassVal"/>
              <c:if test="${nowUser.member_pass eq null }">
              	 <div id=preView style="width:100%;max-width:700px"></div>
              	 <div id=uploadForm>
	             	 <form id="passForm" name="frm" method="post">
						<input type="file" id="imageUploadFile" name="file" />
						<a href="javascript:void(0);" class="btn btn-primary btn-sm btn-block" onclick="fileUpload();" style="width:80px;display:inline;float: right;">
							<i class="far fa-edit"></i> 등록
						</a>	
					 </form>
				 </div>
              </c:if>
              <c:if test="${nowUser.member_pass != null }">
             	 <div id=preView style="width:100%;max-width:700px"><img src="${nowUser.member_pass }" style="width:100%"></div>
             	 <div id=uploadForm>
				 	<a href="javascript:void(0);" class="btn btn-primary btn-sm btn-block" onclick="fileUpdate();" style="width:80px;display:inline;float: left;">
				 		<i class="far fa-edit"></i> 변경
				 	</a>
				 </div>	
              </c:if>
              <small id="numberlHelp" class="form-text text-muted"></small>
          </div>
          <br><br><br><br>
          <button type="submit" class="btn btn-primary" id="submitBtn">수정하기</button>
          <a href="javascript:withdraw();" style="float:right;">탈퇴</a>

   </div>
   
   <script>
   
   		var memberId = "${nowUser.member_id }";
   
		var isNickChecked = true;
	
		var oldName = "${nowUser.member_name }";
		
   		function setNameInput() {
   			isNickChecked = false;
   			$("#memberName").attr("readonly", false);
   			alert("변경할 닉네임을 입력하여주세요!");
   			$("#nickChangeBtn").hide();
   		}
   		
   		//닉네임 input blur 이벤트
   		$("#memberName").blur(function() {
   			
   			if($("#memberName").attr("readonly")) {
   				return false;
   			}
   			
   		    var nickName = $("#memberName").val();
   		    
   		    if(nickName == "" || nickName == null) {
   		    	setMsgSpan("memberName", 0, "닉네임을 올바르게 입력해주세요."); 
   		    	isNickChecked = false;
   		        return false;
   		    }
   		    
   		    // 닉네임 정규식 체크
   		    var regExp = /^[가-힣a-zA-Z0-9\s]+$/
   		       
   		    if(!nickName.match(regExp)) {
   		    	setMsgSpan("memberName", 0, "닉네임은 한글, 숫자, 영문자로 구성되어야 합니다."); 
   		    	isNickChecked = false;
   		        return false;
   		    }
   		   	if(nickName != oldName) {
	   		    $.ajax({
	   		       type: "post", 
	   		       dataType: "text", 
	   		       contentType: "application/x-www-form-urlencoded;charset=utf-8",
	   		       url: "${pageContext.request.contextPath}/checkNick.do",
	   		       data : {nickname : nickName},
	   		       success: function(rtn) {
	   		    	  
	   		    	   //console.log(rtn);
	   		    	   
	   		          if(rtn == "" || rtn == null) {
	   		        	  setMsgSpan("memberName", 0, "닉네임 중복체크에 실패했습니다. 관리자에게 문의하세요."); 
	   		              isNickChecked = false;
	   		              return false;
	   		          }
	   		          
	   		          if (rtn == "success"){
	   		        	  setMsgSpan("memberName", 1, "사용 가능한 닉네임입니다.");
	   		        	  isNickChecked = true;
	   		          }else{
	   		        	  setMsgSpan("memberName", 0, "이미 사용중인 닉네임입니다."); 
	   		        	  isNickChecked = false;
	   		          } 
	   		       },
	   		       error:function(request,status,error){
	   		           alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	   		       }
	   		    });
   		   	} else {
   		  	 	setMsgSpan("memberName", 1, "기존에 사용하던 닉네임입니다.");
	        	isNickChecked = true;
   		   	}
   		    
   		});
   		
   		// 인풋 값에 대한 메시지 출력 기능 function
   		function setMsgSpan(id, type, msg) {
   			var parentElement = $("#" + id).closest(".beforeSpan");
   			
   			// type이 -1 이면 p 삭제
   			if(type == -1) {
   				parentElement.children("p.addtxt_area").remove();
   				return false;
   			}
   			
   			// type이 1이면 긍정 메시지 설정, 1이 아니면 부정 메시지 설정
   			var tmpHtml = (type == 1) ? "<p class='addtxt_area'><span style='color:#57932f'>" + msg + "</span></p>" : "<p class='addtxt_area'><span class='pwInVaild' style='color:#ff3600'>" + msg + "</span></p>";
   			
   			// id 값을 받아와 해당하는 엘리먼트의 마지막 p 태그 삭제
   			parentElement.children("p.addtxt_area").remove();

   			// tmpHtml 추가
   			parentElement.append(tmpHtml);
   			
   		}
   		
   		$("#submitBtn").click(function() {
   			if(!isNickChecked) {
   				alert("닉네임을 확인하여주세요!");
   				return;
   			} else {
   				
   				var nickName = $("#memberName").val();
   				var memberPassVal = $("#memberPassVal").val();
   				
   				$.ajax({
   				       type: "post", 
   				       dataType: "text", 
   				       contentType: "application/x-www-form-urlencoded;charset=utf-8",
   				       url: "${pageContext.request.contextPath}/user/update.do",
   				       data : {memberId : memberId, nickname : nickName, memberpass: memberPassVal},
   				       success: function(rtn) {
   				    	  alert("정보 수정이 완료되었습니다.");
   			        	  window.location.href = '${pageContext.request.contextPath}/main.do';
   				       },
   				       error:function(request,status,error){
   				           alert("회원가입에 실패했습니다. 관리자에게 문의하세요.");
   				       }
   				    });
   			}
   			
   		});
   		
 		
		function fileUpload() {
			var form = jQuery("#passForm")[0];
			var formData = new FormData(form);

			jQuery.ajax({
				url : "${pageContext.request.contextPath}/fupload.do",
				type : "POST",
				processData : false,
				contentType : false,
				dataType: "text",
				data : formData,
				success : function(filename) {
					afterUpload(filename);
				},
				error:function(request,status,error){
			        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			    }
			});
		}
		
		function afterUpload(filename) {
			var filePath = "https://www.gyobab.shop:8883/images/" + filename;
			$("#memberPassVal").val(filePath);
			$("#preView").html("<img src='"+filePath+"' style='width:100%'/>");
			$("#uploadForm").empty();
			var tmpHtml = '<a href="javascript:void(0);" class="btn btn-primary btn-sm btn-block" onclick="fileUpdate();" style="width:80px;display:inline;float: left;">';
			tmpHtml += '<i class="far fa-edit"></i> 변경</a>'
			$("#uploadForm").html(tmpHtml);
		}
		
		function fileUpdate() {
			$("#preView").empty();
			$("#uploadForm").empty();
			
			var tmpHtml = '<form id="passForm" name="frm" method="post"><input type="file" id="imageUploadFile" name="file" />';
			tmpHtml += '<a href="javascript:void(0);" class="btn btn-primary btn-sm btn-block" onclick="fileUpload();" style="width:80px;display:inline;float: right;">';
			tmpHtml += '<i class="far fa-edit"></i> 등록</a></form>';
			
			$("#uploadForm").append(tmpHtml);
		}
		
		function withdraw() {
			var checkWithdraw = confirm("탈퇴하시겠습니까? \n탈퇴하면 회원님의 모든 데이터가 삭제됩니다.");
			if(checkWithdraw) {
				$.ajax({
			       type: "post", 
			       dataType: "text", 
			       contentType: "application/x-www-form-urlencoded;charset=utf-8",
			       url: "${pageContext.request.contextPath}/user/withdraw.do",
			       data : {memberId : memberId},
			       success: function(rtn) {
			    	  alert("탈퇴가 완료되었습니다.");
		        	  window.location.href = '${pageContext.request.contextPath}/main.do';
			       },
			       error:function(request,status,error){
			           alert("탈퇴에 실패했습니다. 관리자에게 문의하세요.");
			       }
			    });
			}
		}
	</script>
   
</div>