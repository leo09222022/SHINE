<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>관리자 페이지</title>
  <style>
    * {
      box-sizing: border-box;
    }

    body {
      font-family: Arial, sans-serif;
      background-color: #f2f2f2;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      margin: 0;
    }

    .login-container {
      background-color: white;
      padding: 40px;
      border-radius: 12px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.1);
      width: 480px;
    }

    h2 {
      text-align: center;
      margin-bottom: 24px;
    }

    form {
      display: flex;
      flex-direction: column;
    }

    input[type="password"] {
      padding: 14px;
      font-size: 16px;
      border: 1px solid #ccc;
      border-radius: 8px;
      width: 100%;
      margin-bottom: 10px;
    }

    .error-message {
      color: red;
      text-align: center;
      font-size: 14px;
      margin-bottom: 12px;
    }

    button {
      padding: 14px;
      background-color: #4CAF50;
      color: white;
      border: none;
      border-radius: 8px;
      cursor: pointer;
      font-size: 16px;
      width: 100%;
    }

    button:hover {
      background-color: #45a049;
    }
  </style>
</head>
<body>
  <div class="login-container">
    <h2>관리자 페이지</h2>
    
    <form method="post" action="AdminLogin">
      <input type="password" name="password" id="password" placeholder="암호를 입력하세요" required />
      
      <c:if test="${re==0 }">
      	<div class="error-message" id="error-msg">올바르지 않은 암호입니다</div>
      </c:if>
      
      <button type="submit">로그인</button>
    </form>
  </div>

  <script>
   
  </script>
</body>
</html>
