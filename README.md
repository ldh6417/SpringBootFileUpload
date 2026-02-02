#📝 MyBatis 기반 자료업로드 데이터베이스 설계 (Oracle)

이 저장소는 Java와 Database를 연동하는 MyBatis 실습을 위한 Oracle SQL 스크립트 및 Mapper 기반 게시판 프로젝트를 포함하고 있습니다.
MyBatis를 활용한 CRUD 및 검색 기능을 통해 DB 연동 원리를 쉽게 이해할 수 있도록 구성되었습니다.

📋 Spring Boot + MyBatis 게시판
📖 소개

MyBatis 방식으로 게시판 CRUD 및 검색 기능을 구현한 실습 프로젝트입니다.

⏰ 개발 기간
* 2026.02.02 ~ 2026.02.02

###  개발 환경
- 운영체제: Windows 11 home
- 개발 도구: SpringBoot 4.1.9
- JDK 버전: OpenJDK 21.0.6
- 프로그래밍 언어: Java 21
- 형상관리 도구: Git, GitHub

## 📌 주요 기능
#### 자료업로드 관리
- 게시글 등록 (제목, 작성자, 내용)
- 게시글 수정 (제목, 내용 변경)
- 게시글 삭제
- 게시글 목록 조회


## 🚀 데이타 베이스 정보
```sql
-- 스크립트 모드 활성화 (12c 이상)
ALTER SESSION SET "_ORACLE_SCRIPT"=true;

-- 기존 사용자 삭제 및 신규 생성
DROP USER KHH CASCADE; 
CREATE USER KHH IDENTIFIED BY KH
    DEFAULT TABLESPACE USERS
    TEMPORARY TABLESPACE TEMP; 

-- 필수 권한 부여
GRANT CONNECT, RESOURCE, DBA TO KH;

# 🛠 2. 테이블 및 시퀀스 생성게시판의 핵심 정보를 저장할 테이블 구조와 게시글 번호 자동 증가를 위한 시퀀스입니다.
테이블 구조

컬럼명,타입,제약조건,설명

CREATE TABLE item( 
    id NUMBER(5), 
    name VARCHAR2(20),
    price NUMBER(6), 
    description VARCHAR2(300), 
    url VARCHAR2(200), 
    PRIMARY KEY (id) 
); 

-- 시퀀스 생성 (1부터 시작)
CREATE SEQUENCE item_SEQ 
START WITH 1 
INCREMENT BY 1;


🔍 3. 주요 SQL 활용 예시
데이터 관리 (CRUD)
➕ 게시글 등록
INSERT INTO item
		(id, name,
		price, description, url)
		VALUES
		(item_seq.NEXTVAL, #{name}, #{price},
		#{description}, #{url})

📋 게시글 생성
<insert id="create" parameterType="Item">
		INSERT INTO item
		(id, name,
		price, description, url)
		VALUES
		(item_seq.NEXTVAL, #{name}, #{price},
		#{description}, #{url})
	</insert>

✏ 게시글 수정
<update id="update">
		UPDATE item
		SET name = #{name},
		price = #{price},
		description = #{description},
		url = #{url}
		WHERE id = #{id}
	</update>

❌ 게시글 삭제
<delete id="delete">
		DELETE FROM item
		WHERE id = #{id}
	</delete>

🔎 게시글 리스트
<select id="read" resultType="Item">
		SELECT
		id,name,price,description,url
		FROM item
		WHERE id = #{id}
	</select>




⚠️ 주의사항실습 중 데이터가 잘못되었다면 ROLLBACK;
명령어로 되돌릴 수 있습니다.
데이터 확정을 위해서는 COMMIT;
