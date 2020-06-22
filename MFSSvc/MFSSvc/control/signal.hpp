//
// Created by 易培淮 on 2019/10/8.
//

#ifndef MFS2ALG_SIGNAL_HPP
#define MFS2ALG_SIGNAL_HPP
#include <boost/signals2.hpp>


namespace Ctrl{
    template <typename T>
    class Singleton
    {
        struct object_creator
        {
            object_creator()
            {
                Singleton<T>::instance();
            }
            inline void do_nothing() const {}
        };

        static object_creator create_object;

    public:
        typedef T object_type;
        static T &instance()
        {
            static T obj;
            create_object.do_nothing();
            return obj;
        }
    };

    template <typename T>
    typename Singleton<T>::object_creator Singleton<T>::create_object;

    class Signal
    {
    public:
        Signal()
        {
        }
        ~Signal()
        {
        }
        friend class Singleton<Signal>;

    public:
        void notify(int id)
        {
            signal_to_send(id);
        }

        template <class F, class... Args>
        void connect(F &&f, Args &&... args)
        {
            signal_connect = signal_to_send.connect(std::bind(f, std::forward<Args>(args)...));
        }
        void disconnect(){
            signal_connect.disconnect();
        }

    private:
        boost::signals2::signal<void(int)> signal_to_send;
        boost::signals2::connection signal_connect;
    };

    class Signal_In : public Signal
    {
    };

    class Signal_Out : public Signal
    {
    };

    class Signal_Close : public Signal
    {
    };

    class Signal_Ctrl : public Signal
    {
    };
    class Signal_Exit: public Signal
    {
    };

}

#endif //MFS2ALG_SIGNAL_HPP
