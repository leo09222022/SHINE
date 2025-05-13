<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>관리자 로그인</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="css/mo_style.css"> <!-- Pretendard 포함 시 -->
  <style>
    * {
      box-sizing: border-box;
    }

    body {
      font-family: 'Pretendard', sans-serif;
      margin: 0;
      padding: 0;
      background-color: #f5f5f5;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
    }

    .login-container {
      background-color: white;
      padding: 32px;
      border-radius: 12px;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
      width: 100%;
      max-width: 400px;
      text-align: center;
    }

    h2 {
      color: #3A81FF;
      font-size: 24px;
      margin-bottom: 24px;
    }

    input[type="password"] {
      width: 100%;
      padding: 14px;
      font-size: 16px;
      border: 1px solid #ccc;
      border-radius: 8px;
      margin-bottom: 16px;
      transition: border 0.2s;
    }

    input[type="password"]:focus {
      outline: none;
      border-color: #3A81FF;
    }

    .error-message {
      color: #E53935;
      font-size: 14px;
      margin-bottom: 16px;
    }

    button {
      width: 100%;
      padding: 14px;
      font-size: 16px;
      background-color: #3A81FF;
      color: white;
      border: none;
      border-radius: 8px;
      cursor: pointer;
      transition: background-color 0.3s;
    }

    button:hover {
      background-color: #2a63cc;
    }

    @media (max-width: 480px) {
      .login-container {
        margin: 0 16px;
      }
    }
  </style>
</head>
<body>
  <div class="login-container">
  	<img src="./img/top_logo.svg"><br><br>
    <h2>관리자 로그인</h2>
    
    <form method="post" action="AdminLogin">
      <input type="password" name="password" id="password" placeholder="암호를 입력하세요" required />

      <c:if test="${re==0 }">
        <div class="error-message">올바르지 않은 암호입니다</div>
      </c:if>

      <button type="submit">로그인</button>
    </form>
  </div>
</body>
</html>
