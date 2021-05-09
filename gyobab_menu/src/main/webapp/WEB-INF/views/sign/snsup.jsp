<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>
	var inMail = "${socialMail}";
	
	console.log("inMail : " + inMail)
	
	if(inMail == null || inMail == "") {
		alert("메일 주소를 받아올 수 없습니다. 메일 주소 권한을 허용 해 주세요!");
		window.location.href = '${pageContext.request.contextPath}/main.do';
	}
</script>

<div class="content">
	<div class="card mb-3">
	    <div class="card-header">
	        <h3><b>회원 가입</b></h3>
	                회원 가입 페이지입니다. <br>
	                회원가입에는 SNS에서 받아온 <b>E-mail 주소</b>와 홈페이지에서 사용할 <b>닉네임</b>이 필요합니다. 
	    </div>
	
	    <div class="card-body">
	
            <div class="form-group">
                <label for="exampleInputEmail1">E-mail</label>
                <input type="text" class="form-control" id="memberEmail" placeholder="${socialMail }" readonly>
                <small id="emailHelp" class="form-text text-muted">이메일 주소는 가입 후 변경할 수 없고, 다른 사람에게 노출되지 않습니다. </small>
            </div>
            <div class="form-group beforeSpan">
                <label for="exampleInputEmail1"><b>닉네임 (필수)</b></label>
                <input type="text" class="form-control" id="memberName" placeholder="" maxlength=10>
                <small id="numberlHelp" class="form-text text-muted">다른 사람에게 보여질 닉네임입니다. 중복 되지 않는 닉네임을 사용하여주세요.</small>
            </div>
            <div class="form-group beforeSpan">
              <label for="exampleInputEmail1"><b>교회 출입 바코드 (선택)</b></label>
              <input type="hidden" value="" id="memberPassVal"/>
              <div id=preView style="width:200px;"></div>
              <div id=uploadForm>
             	 <form id="passForm" name="frm" method="post">
					<input type="file" id="imageUploadFile" name="file" />
					<a href="javascript:void(0);" class="button" onclick="fileUpload();"><span class="new">등록</span></a>	
				 </form>
		      </div>
              <small id="numberlHelp" class="form-text text-muted">온누리교회 출입 바코드를 저장할 수 있습니다.</small>
          </div>
            <br>
            <button type="submit" class="btn btn-primary" id="joinBtn">가입하기</button>
	
	    </div>
	</div>
</div>

<script>
	
	var isNickChecked = false;
	
	//닉네임 input blur 이벤트
	$("#memberName").blur(function() {
		
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
	
	$("#joinBtn").click(function() {
		if(!isNickChecked) {
			alert("닉네임을 확인하여주세요!");
			return;
		} else {
			
			var email = "${socialMail }";
			var nickName = $("#memberName").val();
			var pass = $("#memberPassVal").val();
			
			$.ajax({
			       type: "post", 
			       dataType: "text", 
			       contentType: "application/x-www-form-urlencoded;charset=utf-8",
			       url: "${pageContext.request.contextPath}/singup.do",
			       data : {email : email, nickname : nickName, pass:pass},
			       success: function(rtn) {
		        	  window.location.href = '${pageContext.request.contextPath}/singupcomp.do?nickname='+rtn;
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
		$("#preView").html("<img src='"+filePath+"' />");
		$("#uploadForm").empty();
		$("#uploadForm").html('<a href="javascript:void(0);" class="button" onclick="fileUpdate();"><span class="new">변경</span></a>');
	}
	
	function fileUpdate() {
		$("#preView").empty();
		$("#uploadForm").empty();
		$("#memberPassVal").val("");
		
		var tmpHtml = '<form id="passForm" name="frm" method="post"><input type="file" id="imageUploadFile" name="file" />';
		tmpHtml += '<a href="javascript:void(0);" class="button" onclick="fileUpload();"><span class="new">등록</span></a></form>';
		
		$("#uploadForm").append(tmpHtml);
	}
	
</script>