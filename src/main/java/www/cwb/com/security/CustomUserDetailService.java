package www.cwb.com.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import www.cwb.com.party.Member.mapper.MemberMapper;
import www.cwb.com.party.Member.vo.MemberVO;
import www.cwb.com.security.domain.CustomUser;
@Service
public class CustomUserDetailService implements UserDetailsService {

	
	@Autowired
	private MemberMapper memberMapper;
	
	@Override
	public UserDetails loadUserByUsername(String userName) throws UsernameNotFoundException {
		MemberVO vo = memberMapper.read(userName);
		System.out.println("쿼리 매퍼: " + vo);
		
		return vo == null ? null : new CustomUser(vo);
	}

}
