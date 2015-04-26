package ContextMapper

/**
 * Created by IntelliJ IDEA.
 * User: paulaner
 * Date: 19.09.11
 * Time: 16:25
 * To change this template use File | Settings | File Templates.
 */
import org.springframework.security.core.GrantedAuthority

class MyUserDetails  {

//extra instance variables
final String fullname
final String email
final String title
final String uid


MyUserDetails(String uid, String password, boolean enabled, boolean accountNonExpired, boolean credentialsNonExpired,
              boolean accountNonLocked,String fullname, String email, String title,  Collection<GrantedAuthority> authorities ) {

super(uid, password, enabled, accountNonExpired, credentialsNonExpired, accountNonLocked)
    this.uid = uid
    this.fullname = fullname
    this.email = email
    this.title = title
}
    String toString() {
            return email
        }

}