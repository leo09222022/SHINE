/**
 * search.js - 화장실 검색 자동완성 기능
 */
(function() {
    // 검색 입력란과 자동완성 항목 컨테이너
    const searchInput = document.getElementById('searchInput');
    const autocompleteItems = document.getElementById('autocompleteItems');
    const searchButton = document.getElementById('searchButton');
    
    let currentFocus = -1;
    
    // 화장실 데이터 통합
    let toiletList = [];
    
    // 즉시 실행 함수로 데이터 로드 및 초기화
    function initAutocomplete() {
        // 전체 화장실 데이터가 있으면 먼저 추가
        if (window.allToilets && window.allToilets.length > 0) {
            toiletList = [...window.allToilets];
        }
        
        // 검색 결과 데이터가 있으면 중복 제거하면서 추가
        if (window.searchResults && window.searchResults.length > 0) {
            window.searchResults.forEach(toilet => {
                // 이미 목록에 있는지 확인
                const isDuplicate = toiletList.some(item => 
                    item.name === toilet.name && 
                    item.address === toilet.address);
                    
                // 중복이 아니면 추가
                if (!isDuplicate) {
                    toiletList.push(toilet);
                }
            });
        }
        
        console.log("자동완성을 위한 데이터 로드 완료:", toiletList.length);
        
        // 이벤트 리스너 등록
        setupEventListeners();
        
        // 페이지 로드 즉시 입력값이 있으면 자동완성 실행
        if (searchInput.value.trim()) {
            // 검색어 유지를 위해 입력값을 다시 설정
            const currentValue = searchInput.value.trim();
            
            // 약간의 지연 후 자동완성 표시 (DOM 완전 로드 후)
            setTimeout(() => {
                updateAutocomplete(currentValue);
            }, 100);
        }
    }
    
    // 이벤트 리스너 설정
    function setupEventListeners() {
        // 입력 이벤트 리스너 - 입력이 발생하면 즉시 자동완성 목록 업데이트
        searchInput.addEventListener('input', function() {
            const value = this.value.trim();
            
            // 입력값 없으면 자동완성 숨기기
            if (!value) {
                autocompleteItems.innerHTML = '';
                autocompleteItems.style.display = 'none';
                return;
            }
            
            // 자동완성 목록 업데이트 - 즉시 실행
            updateAutocomplete(value);
        });
        
        // 포커스 이벤트 - 입력란이 포커스를 받으면 자동완성 표시
        searchInput.addEventListener('focus', function() {
            const value = this.value.trim();
            if (value) {
                updateAutocomplete(value);
            }
        });
        
        // 키보드 이벤트 리스너
        searchInput.addEventListener('keydown', function(e) {
            const items = autocompleteItems.getElementsByClassName('autocomplete-item');
            
            if (items.length === 0) return;
            
            // 위 화살표
            if (e.key === 'ArrowUp') {
                currentFocus--;
                setActiveItem(items);
                e.preventDefault();
            }
            // 아래 화살표
            else if (e.key === 'ArrowDown') {
                currentFocus++;
                setActiveItem(items);
                e.preventDefault();
            }
            // 엔터 키
            else if (e.key === 'Enter') {
                e.preventDefault();
                if (currentFocus > -1 && items[currentFocus]) {
                    items[currentFocus].click();
                } else {
                    submitSearch();
                }
            }
            // ESC 키
            else if (e.key === 'Escape') {
                autocompleteItems.innerHTML = '';
                autocompleteItems.style.display = 'none';
                currentFocus = -1;
            }
        });
        
        // 검색 버튼 이벤트 리스너
        searchButton.addEventListener('click', submitSearch);
        
        // 문서 클릭 시 자동완성 닫기 (입력란과 자동완성 항목 외 클릭 시)
        document.addEventListener('click', function(e) {
            if (!searchInput.contains(e.target) && !autocompleteItems.contains(e.target)) {
                autocompleteItems.innerHTML = '';
                autocompleteItems.style.display = 'none';
            }
        });
    }
    
    // 자동완성 항목 업데이트
    function updateAutocomplete(value) {
        // 입력된 값으로 화장실 필터링
        const lowerValue = value.toLowerCase();
        
        // 입력된 값으로 화장실 필터링
        const matches = toiletList.filter(toilet => {
            // null 체크 추가
            const name = toilet.name || '';
            const address = toilet.address || '';
            
            return name.toLowerCase().includes(lowerValue) || 
                   address.toLowerCase().includes(lowerValue);
        }).slice(0, 10); // 최대 10개까지 표시로 증가
        
        // 필터링 결과 없으면 자동완성 숨기기
        if (matches.length === 0) {
            autocompleteItems.innerHTML = '';
            autocompleteItems.style.display = 'none';
            return;
        }
        
        // 자동완성 목록 생성
        autocompleteItems.innerHTML = '';
        matches.forEach(toilet => {
            const item = document.createElement('div');
            item.className = 'autocomplete-item';
            
            // 이름과 주소에 하이라이트 적용
            const highlightedName = applyHighlight(toilet.name || '', lowerValue);
            const highlightedAddress = applyHighlight(toilet.address || '', lowerValue);
            
            item.innerHTML = `
                <div class="search-item">
                    <div class="place-name">${highlightedName}</div>
                    <div class="place-address">${highlightedAddress}</div>
                </div>
            `;
            
            // 항목 클릭 이벤트 처리
            item.addEventListener('click', function() {
                // 입력란에 선택된 이름 넣기
                searchInput.value = toilet.name;
                
                // 자동완성 닫기
                autocompleteItems.innerHTML = '';
                autocompleteItems.style.display = 'none';
                
                // 지도로 이동
                goToMap(toilet.lat, toilet.lng);
            });
            
            autocompleteItems.appendChild(item);
        });
        
        // 자동완성 표시
        autocompleteItems.style.display = 'block';
        currentFocus = -1;
    }
    
    // 활성 항목 설정
    function setActiveItem(items) {
        if (!items) return;
        
        // 모든 항목에서 활성 클래스 제거
        for (let i = 0; i < items.length; i++) {
            items[i].classList.remove('autocomplete-active');
        }
        
        // 인덱스 범위 조정
        if (currentFocus >= items.length) currentFocus = 0;
        if (currentFocus < 0) currentFocus = items.length - 1;
        
        // 선택된 항목에 활성 클래스 추가
        if (items[currentFocus]) {
            items[currentFocus].classList.add('autocomplete-active');
            // 스크롤 위치 조정 (항목이 보이게)
            items[currentFocus].scrollIntoView({ block: 'nearest' });
        }
    }
    
    // 텍스트에 하이라이트 적용
    function applyHighlight(text, keyword) {
        if (!keyword || !text) return text;
        
        try {
            const escapedKeyword = escapeRegExp(keyword);
            const parts = text.split(new RegExp(`(${escapedKeyword})`, 'gi'));
            return parts.map(part => 
                part.toLowerCase() === keyword.toLowerCase() 
                    ? `<span class="highlight">${part}</span>` 
                    : part
            ).join('');
        } catch (e) {
            console.error("하이라이트 적용 오류:", e);
            return text;
        }
    }
    
    // 정규식 특수문자 이스케이프
    function escapeRegExp(string) {
        return string.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
    }
    
    // 초기화 및 자동완성 기능 시작
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', function() {
            // DOM이 완전히 로드된 후 초기화
            initAutocomplete();
            // 검색 입력란에 포커스
            searchInput.focus();
        });
    } else {
        // 이미 DOM이 로드되었으면 즉시 초기화
        initAutocomplete();
        // 검색 입력란에 포커스
        searchInput.focus();
    }
    
    // 전역 함수 설정
    window.submitSearch = function() {
        const keyword = searchInput.value.trim();
        if (keyword) {
            window.location.href = 'toiletSearch.do?keyword=' + encodeURIComponent(keyword);
        }
    };
    
    window.goToMap = function(lat, lng) {
        sessionStorage.setItem('selectedToiletLat', lat);
        sessionStorage.setItem('selectedToiletLng', lng);
        window.location.href = 'map';
    };
})();