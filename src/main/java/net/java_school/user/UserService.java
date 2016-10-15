package net.java_school.user;

import java.util.List;

import org.springframework.security.access.prepost.PreAuthorize;

public interface UserService {
    
  //회원가입
  public void addUser(User user);

  //회원권한 추가
  public void addAuthority(String email, String authority);

  //내 정보 수정
  @PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_USER')")
  public int editAccount(User user);

  //비밀번호 변경
  @PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_USER')")
  public int changePasswd(String currentPasswd, String newPasswd, String email);

  //탈퇴
  @PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_USER') and #user.email == principal.username")
  public void bye(User user);

  //회원찾기
  @PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_USER')")
  public User getUser(String email);

  //회원목록
  @PreAuthorize("hasRole('ROLE_ADMIN')")
  public List<User> getUsers(String search, Integer offset, Integer rowCount);
  
  //회원수
  @PreAuthorize("hasRole('ROLE_ADMIN')")
  public int getTotalCount(String search);
  
  //회원수정
  @PreAuthorize("hasRole('ROLE_ADMIN')")
  public void editAccountByAdmin(User user);

  //회원 비밀번호 변경
  @PreAuthorize("hasRole('ROLE_ADMIN')")
  public void changePasswdByAdmin(User user);
  
  //회원 권한 수정
  @PreAuthorize("hasRole('ROLE_ADMIN')")
  public void changeAuthority(User user);
  
  //회원 삭제
  @PreAuthorize("hasRole('ROLE_ADMIN')")
  public void deleteUser(User user);
  
}