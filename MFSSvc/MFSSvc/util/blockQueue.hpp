//
// Created by 易培淮 on 2019/10/10.
//

#ifndef MFS2ALG_BLOCKQUEUE_HPP
#define MFS2ALG_BLOCKQUEUE_HPP

#include <queue>
#include "boost/thread/condition_variable.hpp"
#include "boost/thread/mutex.hpp"
namespace Util {
    template<typename Data>
    class BlockQueue {
    private:
        std::queue<Data> the_queue;
        mutable boost::mutex the_mutex;
        boost::condition_variable the_condition_variable;

    public:
        void push(Data const &data) {
            boost::mutex::scoped_lock lock(the_mutex);
            the_queue.push(data);
            lock.unlock();
            the_condition_variable.notify_one();
        }

        bool empty() const {
            boost::mutex::scoped_lock lock(the_mutex);
            return the_queue.empty();
        }

        bool try_pop(Data &popped_value) {
            boost::mutex::scoped_lock lock(the_mutex);
            if (the_queue.empty()) {
                return false;
            }
            popped_value = the_queue.front();
            the_queue.pop();
            return true;
        }

        void wait_and_pop(Data &popped_value) {
            boost::mutex::scoped_lock lock(the_mutex);
            while (the_queue.empty()) {
                the_condition_variable.wait(lock);
            }
            popped_value = the_queue.front();
            the_queue.pop();
        }

        void just_remove(){
            boost::mutex::scoped_lock lock(the_mutex);
            if(the_queue.empty()){return;}
            the_queue.pop();
        }

        bool probe(Data &exitTag){
            boost::mutex::scoped_lock lock(the_mutex);
            while (the_queue.empty()) {
                the_condition_variable.wait(lock);
            }
            Data popped_value = the_queue.front();
            return !(popped_value == exitTag);
        }
    };
}


#endif //MFS2ALG_BLOCKQUEUE_HPP
