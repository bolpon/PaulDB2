package ContextMapper

/**
 * Created by IntelliJ IDEA.
 * User: paulaner
 * Date: 21.09.11
 * Time: 16:13
 * To change this template use File | Settings | File Templates.
 */
import org.springframework.ldap.core.DirContextAdapter
import org.springframework.ldap.core.DirContextOperations
import org.springframework.security.core.userdetails.UserDetails
import org.springframework.security.ldap.userdetails.UserDetailsContextMapper

class MyUserDetailsContextMapper implements UserDetailsContextMapper {

UserDetails mapUserFromContext(DirContextOperations ctx, String username, Collection authorities) {

    String fullname = ctx.originalAttrs.attrs['name'].value[0]
    String email = ctx.originalAttrs.attrs['mail'].values[0].toString().toLowerCase()
    String uid= ctx.originalAttrs.attrs['uid'].values[0].toString().toLowerCase()
    def title = ctx.originalAttrs.attrs['title']


new MyUserDetails(uid, null, true, true, true, true, fullname, email,title == null ? '' : title.values[0], authorities ) { }

}

void mapUserToContext(UserDetails user, DirContextAdapter ctx) {
    throw new IllegalStateException("Only retrieving data from AD is currently supported")
}

}
