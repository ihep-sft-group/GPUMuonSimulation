//
// Created by 易培淮 on 2019/10/10.
//

#ifndef MFS2ALG_BASECONTEXT_HPP
#define MFS2ALG_BASECONTEXT_HPP

class BaseContext{
public:
    BaseContext(): m_enable(false) {
    }
    virtual ~BaseContext() = default;
    virtual void exit() = 0;
    virtual void run() = 0;
    virtual void setEnable() = 0;
private:
    bool m_enable;
public:
    bool isMEnable() const{
        return m_enable;
    }
    void setMEnable(bool mEnable){
        m_enable = mEnable;
    }
};


#endif //MFS2ALG_BASECONTEXT_HPP
